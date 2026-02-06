import yaml
from robot.api.deco import keyword

@keyword("Load Test Data From Yaml")
def load_test_data_from_yaml(path: str):
    with open(path, "r", encoding="utf-8") as f:
        return yaml.safe_load(f)