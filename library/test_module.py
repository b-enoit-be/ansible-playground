#!/usr/bin/python
from ansible.module_utils.basic import AnsibleModule

DOCUMENTATION = r'''
---
module: test_module
author: Benoît Geeraerts (@b-enoit-be)
short_description: Just a test module skeleton
description:
    - Gets some parameters as arguments.
    - Returns them unchanged in the C(received) dictionary.
options:
    foo:
        description:
            - a string.
        type: str
        required: true

    bar:
        description:
            - a list.
        type: list
'''

EXAMPLES = r'''
- name: Just a test
  test_module:
    foo: baz
    bar:
      - 1
      - 2
      - 3
'''

RETURN = r'''
received:
    description: The received arguments
    returned: success
    type: dict
    sample: {foo: foo, bar: [1, 2, 3]}
'''

def main():
    module = AnsibleModule(
        argument_spec=dict(
            foo=dict(type='str', required=True),
            bar=dict(type='list', required=False),
        )
    )

    params = module.params

    module.exit_json(
        received={
            'foo': params['foo'],
            'bar': params['bar'],
        },
        changed=True
    )

if __name__ == '__main__':
    main()
