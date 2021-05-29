# usage:
# python pubspec_semver.py ./pubspec.yml --build | --patch | --minor | --major
import ruamel
import ruamel.yaml
import sys
import semver
import subprocess

def number_of_commits():
    res = subprocess.Popen("git log --oneline | wc -l", shell=True, stdout=subprocess.PIPE)
    return int(res.stdout.readline().strip())

if __name__ == '__main__':
    yaml = ruamel.yaml.YAML()

    with open(sys.argv[1]) as f:
        pubspec = yaml.load(f)
        ver = semver.VersionInfo.parse(pubspec['version'])
        build = number_of_commits()
        if sys.argv[2] == '--build':
            ver = ver.replace(build=build)
        if sys.argv[2] == '--patch':
            ver = ver.bump_patch()
            ver = ver.replace(build=build)
        if sys.argv[2] == '--minor':
            ver = ver.bump_minor()
            ver = ver.replace(build=build)
        if sys.argv[2] == '--major':
            ver = ver.bump_major()
            ver = ver.replace(build=build)

        print(ver)
        pubspec['version'] = f'{ver}'

        with open(sys.argv[1], 'w') as file:
            yaml.dump(pubspec, file)