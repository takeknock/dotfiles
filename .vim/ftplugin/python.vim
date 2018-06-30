pythonx << EOF
import subprocess
import sys
path = subprocess.run(['python', '-c', 'import site; print(site.getsitepackage()[0]'], stdout=subprocess.PIPE).stdout
path = path.strip()
path = path.decode('utf-8')
path = str(path)

if not path in sys.path:
    sys.path.append(path)
EOF
