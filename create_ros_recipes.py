import subprocess
import os, sys
import xmltodict

github_repos = [
    'https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_common',
    'https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_nitros',
    'https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_argus_camera',
    'https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_image_pipeline.git',
    'https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_visual_slam.git',
    'https://github.com/zff-ros/isaac_ros_nitros_type.git',
]

def cmd_process(cmd, timeout=600, poll_code=0):
    print('当前执行命令:', cmd)
    s = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, encoding="utf-8",
                            bufsize=1, universal_newlines=True)        
    s.wait(timeout)
    if s.poll() == poll_code:
        c = s.communicate()
        return c
    else:
        return False

rootpath = f'{sys.path[0]}/tmpdir'
oauth_token = 'xxxxx'
# https://docs.github.com/en/rest
# https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-an-organization-repository
def create_github_empty_repo(repo_name):
    cmd = f"""
curl -L \\
  -X POST \\
  -H "Accept: application/vnd.github+json" \\
  -H "Authorization: Bearer {oauth_token}"\\
  -H "X-GitHub-Api-Version: 2022-11-28" \\
  https://api.github.com/orgs/zff-ros/repos \\
  -d '{{"name":"{repo_name}","description":"No description.","homepage":"https://github.com","private":false,"has_issues":true,"has_projects":true,"has_wiki":true}}'
    """
    res = cmd_process(cmd=cmd)
    print(res)

def push_github_code(repo_path):
    repo_name = repo_path.split('/')[-1]
    cmd = f"""
    cd {repo_path};
    git init;
    git remote add origin https://github.com/zff-ros/{repo_name}.git;
    git add .;
    git commit -m "Initial commit";
    git branch -M main
    git push -u origin main;
    """
    res = cmd_process(cmd=cmd)
    print(res)

def get_last_srcrev(repo_path):
    # repo_name = repo_path.split('/')[-1]
    cmd = f"""
    cd {repo_path};
    git rev-parse HEAD;
    """
    res = cmd_process(cmd=cmd)
    return res

def get_package_md5(license):
    license_md5 = 'no license_md5'
    if 'Apache-2.0' == license:
        license_md5 ='12c26a18c7f493fdc7e8a93b16b7c04f'
    elif 'BSD' == license:
        license_md5 ='d566ef916e9dedc494f5f793a6690ba5'
    elif 'MIT' == license:
        license_md5 ='58e54c03ca7f821dd3967e2a2cd1596e'
    elif 'NVIDIA' in license:
        license_md5 ='ec84a5d6851cd927cc8a52a41eeafa53'
    else:
        license_md5 =f'Unknown License {license}'
    return license_md5

def create_github_repos():
    for github_repo in github_repos:
        repo_name = github_repo.split('/')[-1].replace('.git', '')
        for child_repo in os.listdir(f"{rootpath}/{repo_name}"):
            if 'isaac_ros' not in child_repo:
                continue
            print(f"create_github_empty_repo: {child_repo}")
            create_github_empty_repo(child_repo)
            child_repo_path = f"{rootpath}/{repo_name}/{child_repo}"
            push_github_code(child_repo_path)


def format_xml_item(key, item_list):
    if not isinstance(item_list, list):
        item_list = [item_list]
    item_str = f'wrong item: {item_list}'
    if key in ['buildtool_depend', 'buildtool_export_depend']:
        item_str = ' \\\n\t'.join([f'{item}-native'.replace('_', '-') for item in item_list]) + " \\"
    elif key in ['build_depend', 'depend', 'export_depend', 'test_depend']:
        item_str = ' \\\n\t'.join([item.replace('_', '-') for item in item_list]) + " \\"
    return item_str

def generate_ros_recipe(source_path, target_path, **kwargs):
    with open(source_path) as xml_file:
        package_dict = xmltodict.parse(xml_file.read())
    data_dict = package_dict.get('package', {})

    buildtool_depend = format_xml_item('buildtool_depend', data_dict.get('buildtool_depend', []))
    buildtool_export_depend = format_xml_item('buildtool_export_depend', data_dict.get('buildtool_export_depend', []))
    build_depend = format_xml_item('build_depend', data_dict.get('build_depend', []))
    depend = format_xml_item('depend', data_dict.get('depend', []))
    # export_depend = '\\'.join(data_dict.get('export_depend', []))
    test_depend = format_xml_item('test_depend', data_dict.get('test_depend', []))

    license_result = cmd_process(f"grep -n '<license>' {source_path}")
    if license_result:
        license_line = license_result[0].split(':')[0]
    else:
        license_line = 0
    srcrev = kwargs.get('srcrev', '').replace('\n', '')
    package_md5 = get_package_md5(data_dict.get('license', 'no license'))

    template = f"""
# Generated by superflore -- DO NOT EDIT
#
# Copyright Open Source Robotics Foundation

inherit ros_distro_humble
inherit ros_superflore_generated

DESCRIPTION = "{data_dict.get('description', 'NO DESCRIPTION')}"
AUTHOR = "{data_dict.get('maintainer', {}).get('#text', '')} <{data_dict.get('maintainer', {}).get('@email', '')}>"
ROS_AUTHOR = "{','.join(data_dict.get('author', []))}"
HOMEPAGE = "{data_dict.get('url', {}).get('#text', '')}"
SECTION = "devel"
# Original license in package.xml, joined with "&" when multiple license tags were used:
#         "Apache License 2.0"
LICENSE = "{data_dict.get('license', 'no license')}"
LIC_FILES_CHKSUM = "file://package.xml;beginline={license_line};endline={license_line};md5={package_md5}"

ROS_CN = "{data_dict.get('name', 'no name')}"
ROS_BPN = "{data_dict.get('name', 'no name')}"

ROS_BUILD_DEPENDS = " \\
    {build_depend}
"

ROS_BUILDTOOL_DEPENDS = " \\
    {buildtool_depend}
"

ROS_EXPORT_DEPENDS = " \\
    {depend}
"

ROS_BUILDTOOL_EXPORT_DEPENDS = " \\
    {buildtool_export_depend}
"

ROS_EXEC_DEPENDS = " \\
    {depend}
"

# Currently informational only -- see http://www.ros.org/reps/rep-0149.html#dependency-tags.
ROS_TEST_DEPENDS = " \\
    {test_depend}
"

DEPENDS = "${{ROS_BUILD_DEPENDS}} ${{ROS_BUILDTOOL_DEPENDS}}"
# Bitbake doesn't support the "export" concept, so build them as if we needed them to build this package (even though we actually
# don't) so that they're guaranteed to have been staged should this package appear in another's DEPENDS.
DEPENDS += "${{ROS_EXPORT_DEPENDS}} ${{ROS_BUILDTOOL_EXPORT_DEPENDS}}"

RDEPENDS:${{PN}} += "${{ROS_EXEC_DEPENDS}}"

# matches with: https://github.com/ros2-gbp/ament_cmake-release/archive/release/humble/ament_cmake/1.3.1-2.tar.gz
ROS_BRANCH ?= "branch=main"
SRC_URI = "git://github.com/zff-ros/{data_dict.get('name', 'no name')};${{ROS_BRANCH}};protocol=https"
SRCREV = "{srcrev}"
S = "${{WORKDIR}}/git"

ROS_BUILD_TYPE = "{data_dict.get('export', {}).get('build_type', 'no build_type')}"

inherit ros_${{ROS_BUILD_TYPE}}
    """
    with open(target_path, 'w') as f:
        f.write(template)


def create_all_recipes():
    for github_repo in github_repos:
        repo_name = github_repo.split('/')[-1].replace('.git', '')
        for child_repo in os.listdir(f"{rootpath}/{repo_name}"):
            if 'isaac_ros' not in child_repo:
                continue
            print(f"create_recipe: {child_repo}")
            source_path = f"{rootpath}/{repo_name}/{child_repo}/package.xml"
            cmd_process(cmd=f"mkdir -p {rootpath}/generated-recipes/{repo_name.replace('_','-')}")
            target_path = f"{rootpath}/generated-recipes/{repo_name.replace('_','-')}/{child_repo.replace('_','-')}_%.bb"
            child_repo_path = f"{rootpath}/{repo_name}/{child_repo}"

            srcrev = get_last_srcrev(child_repo_path)
            if srcrev:
                srcrev = srcrev[0]
            else:
                srcrev = 'no srcrev'

            try:
                generate_ros_recipe(source_path, target_path, srcrev=srcrev)
            except Exception as e:
                print(e)
                print(f'[ERROR]>>>>>>>{source_path}')


if __name__ == "__main__":
    # create_github_repos()
    # source_path = 
    # target_path = 
    # generate_ros_recipe(source_path, target_path)
    create_all_recipes()