{
  lib,
  fetchPypi,
  python313Packages,
}:

python313Packages.buildPythonPackage rec {
  pname = "headless-ida";
  version = "0.6.7";
  pyproject = true;

  src = fetchPypi {
    pname = "headless-ida";
    version = version;
    pypiName = "headless_ida";
    sha256 = "sha256-qCFyP1Bay5FK+0NQbIWahCc9OpM6pzKGrSpaBB7FnDk=";
  };

  nativeBuildInputs = with python313Packages; [
    setuptools
    setuptools-scm
  ];

  propagatedBuildInputs = with python313Packages; [
    rpyc
  ];

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  pythonImportsCheck = [
    "headless_ida"
  ];

  meta = with lib; {
    description = "Headless IDA";
    homepage = "https://github.com/DennyDai/headless-ida";
    license = licenses.mit;
  };
}
