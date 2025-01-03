$Web::IDL::_Defs = {
          "allowed_xattrs" => {
                                "ArrayBuffer" => {
                                                   "AllowShared" => 1
                                                 },
                                "DOMString" => {
                                                 "TreatNullAs" => 1
                                               },
                                "DataView" => {
                                                "AllowShared" => 1
                                              },
                                "Float32Array" => {
                                                    "AllowShared" => 1
                                                  },
                                "Float64Array" => {
                                                    "AllowShared" => 1
                                                  },
                                "Int16Array" => {
                                                  "AllowShared" => 1
                                                },
                                "Int32Array" => {
                                                  "AllowShared" => 1
                                                },
                                "Int8Array" => {
                                                 "AllowShared" => 1
                                               },
                                "Uint16Array" => {
                                                   "AllowShared" => 1
                                                 },
                                "Uint32Array" => {
                                                   "AllowShared" => 1
                                                 },
                                "Uint8Array" => {
                                                  "AllowShared" => 1
                                                },
                                "Uint8ClampedArray" => {
                                                         "AllowShared" => 1
                                                       },
                                "async_iterable" => {
                                                      "Exposed" => 1,
                                                      "SecureContext" => 1
                                                    },
                                "attribute" => {
                                                 "CEReactions" => 1,
                                                 "Exposed" => 1,
                                                 "LenientSetter" => 1,
                                                 "LenientThis" => 1,
                                                 "PutForwards" => 1,
                                                 "Replaceable" => 1,
                                                 "SameObject" => 1,
                                                 "SecureContext" => 1,
                                                 "Unforgeable" => 1,
                                                 "Unscopable" => 1
                                               },
                                "byte" => {
                                            "Clamp" => 1,
                                            "EnforceRange" => 1
                                          },
                                "callback" => {
                                                "TreatNonObjectAsNull" => 1
                                              },
                                "callback_interface" => {
                                                          "Exposed" => 1,
                                                          "SecureContext" => 1
                                                        },
                                "const" => {
                                             "Exposed" => 1,
                                             "SecureContext" => 1
                                           },
                                "interface" => {
                                                 "Exposed" => 1,
                                                 "Global" => 1,
                                                 "HTMLConstructor" => 1,
                                                 "LegacyArrayClass" => 1,
                                                 "LegacyUnenumerableNamedProperties" => 1,
                                                 "LegacyWindowAlias" => 1,
                                                 "NamedConstructor" => 1,
                                                 "NoInterfaceObject" => 1,
                                                 "OverrideBuiltins" => 1,
                                                 "SecureContext" => 1,
                                                 "Serializable" => 1,
                                                 "Transferable" => 1
                                               },
                                "interface_mixin" => {
                                                       "Exposed" => 1,
                                                       "SecureContext" => 1
                                                     },
                                "iterable" => {
                                                "Exposed" => 1,
                                                "SecureContext" => 1
                                              },
                                "long" => {
                                            "Clamp" => 1,
                                            "EnforceRange" => 1
                                          },
                                "long long" => {
                                                 "Clamp" => 1,
                                                 "EnforceRange" => 1
                                               },
                                "maplike" => {
                                               "SecureContext" => 1
                                             },
                                "namespace" => {
                                                 "Exposed" => 1,
                                                 "SecureContext" => 1
                                               },
                                "octet" => {
                                             "Clamp" => 1,
                                             "EnforceRange" => 1
                                           },
                                "operation" => {
                                                 "CEReactions" => 1,
                                                 "Default" => 1,
                                                 "Exposed" => 1,
                                                 "NewObject" => 1,
                                                 "SecureContext" => 1,
                                                 "Unforgeable" => 1,
                                                 "Unscopable" => 1
                                               },
                                "partial_interface" => {
                                                         "Exposed" => 1,
                                                         "Global" => 1,
                                                         "OverrideBuiltins" => 1,
                                                         "SecureContext" => 1,
                                                         "Serializable" => 1,
                                                         "Transferable" => 1
                                                       },
                                "partial_interface_mixin" => {
                                                               "Exposed" => 1,
                                                               "SecureContext" => 1
                                                             },
                                "partial_namespace" => {
                                                         "Exposed" => 1,
                                                         "SecureContext" => 1
                                                       },
                                "setlike" => {
                                               "SecureContext" => 1
                                             },
                                "short" => {
                                             "Clamp" => 1,
                                             "EnforceRange" => 1
                                           },
                                "static_attribute" => {
                                                        "Exposed" => 1,
                                                        "SameObject" => 1,
                                                        "SecureContext" => 1
                                                      },
                                "static_operation" => {
                                                        "Exposed" => 1,
                                                        "NewObject" => 1,
                                                        "SecureContext" => 1
                                                      },
                                "unsigned long" => {
                                                     "Clamp" => 1,
                                                     "EnforceRange" => 1
                                                   },
                                "unsigned long long" => {
                                                          "Clamp" => 1,
                                                          "EnforceRange" => 1
                                                        },
                                "unsigned short" => {
                                                      "Clamp" => 1,
                                                      "EnforceRange" => 1
                                                    }
                              },
          "grammer" => {
                         "Argument" => {
                                         "patterns" => [
                                                         [
                                                           {
                                                             "type" => "rule",
                                                             "value" => "_Argument"
                                                           }
                                                         ]
                                                       ],
                                         "set_index" => 1
                                       },
                         "ArgumentList" => {
                                             "can_be_empty" => 1,
                                             "ensure_arrayref" => "arguments",
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "append" => "arguments",
                                                                 "type" => "rule",
                                                                 "value" => "Argument"
                                                               },
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "Arguments"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "ArgumentName" => {
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "_ArgumentNameKeyword"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "_Name"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "ArgumentNameKeyword" => {
                                                    "patterns" => [
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "async"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "attribute"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "callback"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "const"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "constructor"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "deleter"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "dictionary"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "enum"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "getter"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "includes"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "inherit"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "interface"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "iterable"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "maplike"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "namespace"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "partial"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "record"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "required"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "setlike"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "setter"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "static"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "stringifier"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "typedef"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "name",
                                                                        "type" => "unrestricted"
                                                                      }
                                                                    ]
                                                                  ]
                                                  },
                         "Arguments" => {
                                          "can_be_empty" => 1,
                                          "patterns" => [
                                                          [
                                                            {
                                                              "type" => ","
                                                            },
                                                            {
                                                              "append" => "arguments",
                                                              "type" => "rule",
                                                              "value" => "Argument"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "Arguments"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "AsyncIterable" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "set_true" => "async",
                                                                  "type" => "async"
                                                                },
                                                                {
                                                                  "set_type" => "member_type",
                                                                  "type" => "iterable"
                                                                },
                                                                {
                                                                  "type" => "<"
                                                                },
                                                                {
                                                                  "set" => "type1",
                                                                  "type" => "rule",
                                                                  "value" => "TypeWithExtendedAttributes"
                                                                },
                                                                {
                                                                  "type" => ","
                                                                },
                                                                {
                                                                  "set" => "type2",
                                                                  "type" => "rule",
                                                                  "value" => "TypeWithExtendedAttributes"
                                                                },
                                                                {
                                                                  "type" => ">"
                                                                },
                                                                {
                                                                  "type" => ";"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "AttributeName" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "_Name"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "_AttributeNameKeyword"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "AttributeNameKeyword" => {
                                                     "patterns" => [
                                                                     [
                                                                       {
                                                                         "set_type" => "name",
                                                                         "type" => "async"
                                                                       }
                                                                     ],
                                                                     [
                                                                       {
                                                                         "set_type" => "name",
                                                                         "type" => "required"
                                                                       }
                                                                     ]
                                                                   ]
                                                   },
                         "AttributeRest" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "ReadOnly"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "_RWAttributeRest"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "BooleanLiteral" => {
                                               "patterns" => [
                                                               [
                                                                 {
                                                                   "set_type" => "value",
                                                                   "type" => "true"
                                                                 }
                                                               ],
                                                               [
                                                                 {
                                                                   "set_type" => "value",
                                                                   "type" => "false"
                                                                 }
                                                               ]
                                                             ]
                                             },
                         "BufferRelatedType" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "ArrayBuffer"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "DataView"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Int8Array"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Int16Array"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Int32Array"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Uint8Array"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Uint16Array"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Uint32Array"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Uint8ClampedArray"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Float32Array"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_type" => "type",
                                                                      "type" => "Float64Array"
                                                                    }
                                                                  ]
                                                                ]
                                                },
                         "CallbackInterfaceMember" => {
                                                        "patterns" => [
                                                                        [
                                                                          {
                                                                            "type" => "rule",
                                                                            "value" => "Const"
                                                                          }
                                                                        ],
                                                                        [
                                                                          {
                                                                            "type" => "rule",
                                                                            "value" => "RegularOperation"
                                                                          }
                                                                        ]
                                                                      ]
                                                      },
                         "CallbackInterfaceMembers" => {
                                                         "patterns" => [
                                                                         [
                                                                           {
                                                                             "append" => "members",
                                                                             "multiple" => 1,
                                                                             "type" => "rule",
                                                                             "value" => "_CallbackInterfaceMember"
                                                                           }
                                                                         ]
                                                                       ]
                                                       },
                         "CallbackOrInterfaceOrMixin" => {
                                                           "patterns" => [
                                                                           [
                                                                             {
                                                                               "type" => "rule",
                                                                               "value" => "_Callback"
                                                                             }
                                                                           ],
                                                                           [
                                                                             {
                                                                               "type" => "rule",
                                                                               "value" => "_InterfaceOrMixin"
                                                                             }
                                                                           ]
                                                                         ]
                                                         },
                         "CallbackRest" => {
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "_Name"
                                                               },
                                                               {
                                                                 "type" => "="
                                                               },
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "ReturnType"
                                                               },
                                                               {
                                                                 "type" => "("
                                                               },
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "ArgumentList"
                                                               },
                                                               {
                                                                 "type" => ")"
                                                               },
                                                               {
                                                                 "type" => ";"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "Const" => {
                                      "patterns" => [
                                                      [
                                                        {
                                                          "set_type" => "member_type",
                                                          "type" => "const"
                                                        },
                                                        {
                                                          "type" => "rule",
                                                          "value" => "ConstType"
                                                        },
                                                        {
                                                          "type" => "rule",
                                                          "value" => "_Name"
                                                        },
                                                        {
                                                          "type" => "="
                                                        },
                                                        {
                                                          "type" => "rule",
                                                          "value" => "ConstValue"
                                                        },
                                                        {
                                                          "type" => ";"
                                                        }
                                                      ]
                                                    ]
                                    },
                         "ConstType" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "type" => "rule",
                                                              "value" => "PrimitiveType"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "set_value" => "type_name",
                                                              "type" => "identifier"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "ConstValue" => {
                                           "patterns" => [
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "BooleanLiteral"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "FloatLiteral"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_value" => "value_integer",
                                                               "type" => "integer"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "Constructor" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "_IDInSpecDirective"
                                                              },
                                                              {
                                                                "set_type" => "member_type",
                                                                "type" => "constructor"
                                                              },
                                                              {
                                                                "type" => "("
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "ArgumentList"
                                                              },
                                                              {
                                                                "type" => ")"
                                                              },
                                                              {
                                                                "type" => ";"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "Default" => {
                                        "can_be_empty" => 1,
                                        "patterns" => [
                                                        [
                                                          {
                                                            "type" => "="
                                                          },
                                                          {
                                                            "type" => "rule",
                                                            "value" => "DefaultValue"
                                                          }
                                                        ]
                                                      ]
                                      },
                         "DefaultValue" => {
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "ConstValue"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "_IDInSpecDirectiveIgnored"
                                                               },
                                                               {
                                                                 "set_value" => "value_string",
                                                                 "type" => "string"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "type" => "["
                                                               },
                                                               {
                                                                 "set_true" => "value_empty_sequence",
                                                                 "type" => "]"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "type" => "{"
                                                               },
                                                               {
                                                                 "set_true" => "value_empty_dictionary",
                                                                 "type" => "}"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "Definition" => {
                                           "patterns" => [
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "CallbackOrInterfaceOrMixin"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Namespace"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Partial"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Dictionary"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Enum"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Typedef"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "IncludesStatement"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "Definitions" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "_SpecDirective"
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "_ObsoleteDirective"
                                                              },
                                                              {
                                                                "append" => "definitions",
                                                                "multiple" => 1,
                                                                "type" => "rule",
                                                                "value" => "_Definition"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "Dictionary" => {
                                           "patterns" => [
                                                           [
                                                             {
                                                               "set_type" => "definition_type",
                                                               "type" => "dictionary"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "_Name"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Inheritance"
                                                             },
                                                             {
                                                               "type" => "{"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "DictionaryMembers"
                                                             },
                                                             {
                                                               "type" => "}"
                                                             },
                                                             {
                                                               "type" => ";"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "DictionaryMember" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "ExtendedAttributeList"
                                                                   },
                                                                   {
                                                                     "set_true" => "required",
                                                                     "type" => "required"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "TypeWithExtendedAttributes"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "_Name"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "Default"
                                                                   },
                                                                   {
                                                                     "type" => ";"
                                                                   }
                                                                 ],
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "ExtendedAttributeList"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "Type"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "_Name"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "Default"
                                                                   },
                                                                   {
                                                                     "type" => ";"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "DictionaryMembers" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "append" => "members",
                                                                      "multiple" => 1,
                                                                      "type" => "rule",
                                                                      "value" => "_DictionaryMember"
                                                                    }
                                                                  ]
                                                                ]
                                                },
                         "DistinguishableType" => {
                                                    "patterns" => [
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "PrimitiveType"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "StringType"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "_IDInSpecDirectiveIgnored"
                                                                      },
                                                                      {
                                                                        "set_value" => "type_name",
                                                                        "type" => "identifier"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set" => "type_parameterized",
                                                                        "type" => "rule",
                                                                        "value" => "_SequenceType"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "type",
                                                                        "type" => "object"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "type",
                                                                        "type" => "Date"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "type",
                                                                        "type" => "RegExp"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set_type" => "type",
                                                                        "type" => "DOMException"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "BufferRelatedType"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set" => "type_parameterized",
                                                                        "type" => "rule",
                                                                        "value" => "_FrozenArrayType"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "set" => "type_parameterized",
                                                                        "type" => "rule",
                                                                        "value" => "RecordType"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "Null"
                                                                      }
                                                                    ]
                                                                  ]
                                                  },
                         "Ellipsis" => {
                                         "can_be_empty" => 1,
                                         "patterns" => [
                                                         [
                                                           {
                                                             "set_true" => "variadic",
                                                             "type" => "..."
                                                           }
                                                         ]
                                                       ]
                                       },
                         "Enum" => {
                                     "patterns" => [
                                                     [
                                                       {
                                                         "set_type" => "definition_type",
                                                         "type" => "enum"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "_Name"
                                                       },
                                                       {
                                                         "type" => "{"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "EnumValueList"
                                                       },
                                                       {
                                                         "type" => "}"
                                                       },
                                                       {
                                                         "type" => ";"
                                                       }
                                                     ]
                                                   ]
                                   },
                         "EnumValueList" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "append" => "value_items",
                                                                  "type" => "rule",
                                                                  "value" => "_EnumItem"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "EnumValueListComma"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "EnumValueListComma" => {
                                                   "can_be_empty" => 1,
                                                   "patterns" => [
                                                                   [
                                                                     {
                                                                       "type" => ","
                                                                     },
                                                                     {
                                                                       "type" => "rule",
                                                                       "value" => "EnumValueListString"
                                                                     }
                                                                   ]
                                                                 ]
                                                 },
                         "EnumValueListString" => {
                                                    "can_be_empty" => 1,
                                                    "patterns" => [
                                                                    [
                                                                      {
                                                                        "append" => "value_items",
                                                                        "type" => "rule",
                                                                        "value" => "_EnumItem"
                                                                      },
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "EnumValueListComma"
                                                                      }
                                                                    ]
                                                                  ]
                                                  },
                         "ExtendedAttribute" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "ExtendedAttributeArgList"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "ExtendedAttributeNamedArgList"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "ExtendedAttributeIdentList"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "ExtendedAttributeNoArgs"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "ExtendedAttributeIdent"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "ExtendedAttributeWildcard"
                                                                    }
                                                                  ]
                                                                ],
                                                  "set_index" => 1
                                                },
                         "ExtendedAttributeArgList" => {
                                                         "patterns" => [
                                                                         [
                                                                           {
                                                                             "type" => "rule",
                                                                             "value" => "_IDInSpecDirective"
                                                                           },
                                                                           {
                                                                             "set_value" => "name",
                                                                             "type" => "identifier"
                                                                           },
                                                                           {
                                                                             "type" => "("
                                                                           },
                                                                           {
                                                                             "type" => "rule",
                                                                             "value" => "ArgumentList"
                                                                           },
                                                                           {
                                                                             "type" => ")"
                                                                           }
                                                                         ]
                                                                       ]
                                                       },
                         "ExtendedAttributeIdent" => {
                                                       "patterns" => [
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "_IDInSpecDirective"
                                                                         },
                                                                         {
                                                                           "set_value" => "name",
                                                                           "type" => "identifier"
                                                                         },
                                                                         {
                                                                           "type" => "="
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "_IDInSpecDirective"
                                                                         },
                                                                         {
                                                                           "append_value" => "value_names",
                                                                           "next_is_not" => {
                                                                                              "(" => 1,
                                                                                              "=" => 1
                                                                                            },
                                                                           "type" => "identifier"
                                                                         }
                                                                       ]
                                                                     ]
                                                     },
                         "ExtendedAttributeIdentList" => {
                                                           "patterns" => [
                                                                           [
                                                                             {
                                                                               "type" => "rule",
                                                                               "value" => "_IDInSpecDirective"
                                                                             },
                                                                             {
                                                                               "set_value" => "name",
                                                                               "type" => "identifier"
                                                                             },
                                                                             {
                                                                               "type" => "="
                                                                             },
                                                                             {
                                                                               "type" => "("
                                                                             },
                                                                             {
                                                                               "type" => "rule",
                                                                               "value" => "IdentifierList"
                                                                             },
                                                                             {
                                                                               "type" => ")"
                                                                             }
                                                                           ]
                                                                         ]
                                                         },
                         "ExtendedAttributeInner" => {
                                                       "can_be_empty" => 1,
                                                       "patterns" => [
                                                                       [
                                                                         {
                                                                           "set_type" => "item_type",
                                                                           "type" => "("
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         },
                                                                         {
                                                                           "type" => ")"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "set_type" => "item_type",
                                                                           "type" => "["
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         },
                                                                         {
                                                                           "type" => "]"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "set_type" => "item_type",
                                                                           "type" => "{"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         },
                                                                         {
                                                                           "type" => "}"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "OtherOrComma"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         }
                                                                       ]
                                                                     ]
                                                     },
                         "ExtendedAttributeList" => {
                                                      "can_be_empty" => 1,
                                                      "patterns" => [
                                                                      [
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "_ExtendedAttributeList"
                                                                        }
                                                                      ]
                                                                    ]
                                                    },
                         "ExtendedAttributeNamedArgList" => {
                                                              "patterns" => [
                                                                              [
                                                                                {
                                                                                  "type" => "rule",
                                                                                  "value" => "_IDInSpecDirective"
                                                                                },
                                                                                {
                                                                                  "set_value" => "name",
                                                                                  "type" => "identifier"
                                                                                },
                                                                                {
                                                                                  "type" => "="
                                                                                },
                                                                                {
                                                                                  "type" => "rule",
                                                                                  "value" => "_IDInSpecDirective"
                                                                                },
                                                                                {
                                                                                  "append_value" => "value_names",
                                                                                  "type" => "identifier"
                                                                                },
                                                                                {
                                                                                  "type" => "("
                                                                                },
                                                                                {
                                                                                  "type" => "rule",
                                                                                  "value" => "ArgumentList"
                                                                                },
                                                                                {
                                                                                  "type" => ")"
                                                                                }
                                                                              ]
                                                                            ]
                                                            },
                         "ExtendedAttributeNoArgs" => {
                                                        "patterns" => [
                                                                        [
                                                                          {
                                                                            "type" => "rule",
                                                                            "value" => "_IDInSpecDirective"
                                                                          },
                                                                          {
                                                                            "next_is_not" => {
                                                                                               "(" => 1,
                                                                                               "=" => 1
                                                                                             },
                                                                            "set_value" => "name",
                                                                            "type" => "identifier"
                                                                          }
                                                                        ]
                                                                      ]
                                                      },
                         "ExtendedAttributeRest" => {
                                                      "can_be_empty" => 1,
                                                      "patterns" => [
                                                                      [
                                                                        {
                                                                          "append" => "extended_attributes",
                                                                          "type" => "rule",
                                                                          "value" => "ExtendedAttribute"
                                                                        }
                                                                      ]
                                                                    ]
                                                    },
                         "ExtendedAttributeWildcard" => {
                                                          "patterns" => [
                                                                          [
                                                                            {
                                                                              "type" => "rule",
                                                                              "value" => "_IDInSpecDirective"
                                                                            },
                                                                            {
                                                                              "set_value" => "name",
                                                                              "type" => "identifier"
                                                                            },
                                                                            {
                                                                              "type" => "="
                                                                            },
                                                                            {
                                                                              "type" => "rule",
                                                                              "value" => "_IDInSpecDirective"
                                                                            },
                                                                            {
                                                                              "append_value" => "value_names",
                                                                              "type" => "other",
                                                                              "value" => "*"
                                                                            }
                                                                          ]
                                                                        ]
                                                        },
                         "ExtendedAttributes" => {
                                                   "can_be_empty" => 1,
                                                   "patterns" => [
                                                                   [
                                                                     {
                                                                       "type" => ","
                                                                     },
                                                                     {
                                                                       "append" => "extended_attributes",
                                                                       "type" => "rule",
                                                                       "value" => "ExtendedAttribute"
                                                                     },
                                                                     {
                                                                       "type" => "rule",
                                                                       "value" => "ExtendedAttributes"
                                                                     }
                                                                   ]
                                                                 ]
                                                 },
                         "FloatLiteral" => {
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "set_value" => "value_float",
                                                                 "type" => "float"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "set_type" => "value",
                                                                 "type" => "-Infinity"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "set_type" => "value",
                                                                 "type" => "Infinity"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "set_type" => "value",
                                                                 "type" => "NaN"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "FloatType" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "set_type" => "type",
                                                              "type" => "float"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "set_type" => "type",
                                                              "type" => "double"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "IdentifierList" => {
                                               "patterns" => [
                                                               [
                                                                 {
                                                                   "append_value" => "value_names",
                                                                   "next_is_not" => {
                                                                                      "(" => 1,
                                                                                      "=" => 1
                                                                                    },
                                                                   "type" => "identifier"
                                                                 },
                                                                 {
                                                                   "type" => "rule",
                                                                   "value" => "Identifiers"
                                                                 }
                                                               ]
                                                             ]
                                             },
                         "Identifiers" => {
                                            "can_be_empty" => 1,
                                            "patterns" => [
                                                            [
                                                              {
                                                                "type" => ","
                                                              },
                                                              {
                                                                "append_value" => "value_names",
                                                                "next_is_not" => {
                                                                                   "(" => 1,
                                                                                   "=" => 1
                                                                                 },
                                                                "type" => "identifier"
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "Identifiers"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "IncludesStatement" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "set_value" => "name",
                                                                      "type" => "identifier"
                                                                    },
                                                                    {
                                                                      "set_type" => "definition_type",
                                                                      "type" => "includes"
                                                                    },
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "_SuperName"
                                                                    },
                                                                    {
                                                                      "type" => ";"
                                                                    }
                                                                  ]
                                                                ]
                                                },
                         "Inherit" => {
                                        "can_be_empty" => 1,
                                        "patterns" => [
                                                        [
                                                          {
                                                            "set_true" => "inherit",
                                                            "type" => "inherit"
                                                          }
                                                        ]
                                                      ]
                                      },
                         "Inheritance" => {
                                            "can_be_empty" => 1,
                                            "patterns" => [
                                                            [
                                                              {
                                                                "type" => ":"
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "_SuperName"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "IntegerType" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "set_type" => "type",
                                                                "type" => "short"
                                                              }
                                                            ],
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "_LongLong"
                                                              }
                                                            ],
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "_Long"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "InterfaceMember" => {
                                                "patterns" => [
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "PartialInterfaceMember"
                                                                  }
                                                                ],
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "Constructor"
                                                                  }
                                                                ]
                                                              ]
                                              },
                         "InterfaceMembers" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "append" => "members",
                                                                     "multiple" => 1,
                                                                     "type" => "rule",
                                                                     "value" => "_InterfaceMember"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "InterfaceOrMixin" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "InterfaceRest"
                                                                   }
                                                                 ],
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "MixinRest"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "InterfaceRest" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "_Name"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "Inheritance"
                                                                },
                                                                {
                                                                  "type" => "{"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "InterfaceMembers"
                                                                },
                                                                {
                                                                  "type" => "}"
                                                                },
                                                                {
                                                                  "type" => ";"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "Iterable" => {
                                         "patterns" => [
                                                         [
                                                           {
                                                             "set_type" => "member_type",
                                                             "type" => "iterable"
                                                           },
                                                           {
                                                             "type" => "<"
                                                           },
                                                           {
                                                             "set" => "type1",
                                                             "type" => "rule",
                                                             "value" => "TypeWithExtendedAttributes"
                                                           },
                                                           {
                                                             "type" => "rule",
                                                             "value" => "OptionalType"
                                                           },
                                                           {
                                                             "type" => ">"
                                                           },
                                                           {
                                                             "type" => ";"
                                                           }
                                                         ]
                                                       ]
                                       },
                         "MaplikeRest" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "set_type" => "member_type",
                                                                "type" => "maplike"
                                                              },
                                                              {
                                                                "type" => "<"
                                                              },
                                                              {
                                                                "set" => "type1",
                                                                "type" => "rule",
                                                                "value" => "TypeWithExtendedAttributes"
                                                              },
                                                              {
                                                                "type" => ","
                                                              },
                                                              {
                                                                "set" => "type2",
                                                                "type" => "rule",
                                                                "value" => "TypeWithExtendedAttributes"
                                                              },
                                                              {
                                                                "type" => ">"
                                                              },
                                                              {
                                                                "type" => ";"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "MixinMember" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "Const"
                                                              }
                                                            ],
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "RegularOperation"
                                                              }
                                                            ],
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "Stringifier"
                                                              }
                                                            ],
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "ReadOnly"
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "AttributeRest"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "MixinMembers" => {
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "append" => "members",
                                                                 "multiple" => 1,
                                                                 "type" => "rule",
                                                                 "value" => "_MixinMember"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "MixinRest" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "set_true" => "mixin",
                                                              "type" => "mixin"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "_Name"
                                                            },
                                                            {
                                                              "type" => "{"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "MixinMembers"
                                                            },
                                                            {
                                                              "type" => "}"
                                                            },
                                                            {
                                                              "type" => ";"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "Namespace" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "set_type" => "definition_type",
                                                              "type" => "namespace"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "_Name"
                                                            },
                                                            {
                                                              "type" => "{"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "NamespaceMembers"
                                                            },
                                                            {
                                                              "type" => "}"
                                                            },
                                                            {
                                                              "type" => ";"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "NamespaceMember" => {
                                                "patterns" => [
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "_NamespaceOperation"
                                                                  }
                                                                ],
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "_ReadOnlyAttributeRest"
                                                                  }
                                                                ]
                                                              ]
                                              },
                         "NamespaceMembers" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "append" => "members",
                                                                     "multiple" => 1,
                                                                     "type" => "rule",
                                                                     "value" => "_NamespaceMember"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "Null" => {
                                     "can_be_empty" => 1,
                                     "patterns" => [
                                                     [
                                                       {
                                                         "set_true" => "type_nullable",
                                                         "type" => "?"
                                                       }
                                                     ]
                                                   ]
                                   },
                         "Operation" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "type" => "rule",
                                                              "value" => "RegularOperation"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "type" => "rule",
                                                              "value" => "SpecialOperation"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "OperationName" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "_Name"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "_OperationNameKeyword"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "OperationNameKeyword" => {
                                                     "patterns" => [
                                                                     [
                                                                       {
                                                                         "set_type" => "name",
                                                                         "type" => "includes"
                                                                       }
                                                                     ]
                                                                   ]
                                                   },
                         "OperationRest" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "OptionalOperationName"
                                                                },
                                                                {
                                                                  "type" => "("
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "ArgumentList"
                                                                },
                                                                {
                                                                  "type" => ")"
                                                                },
                                                                {
                                                                  "type" => ";"
                                                                }
                                                              ]
                                                            ],
                                              "set_fields" => [
                                                                [
                                                                  "member_type",
                                                                  "operation"
                                                                ]
                                                              ]
                                            },
                         "OptionalLong" => {
                                             "can_be_empty" => 1,
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "type" => "long"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "OptionalOperationName" => {
                                                      "can_be_empty" => 1,
                                                      "patterns" => [
                                                                      [
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "OperationName"
                                                                        }
                                                                      ]
                                                                    ]
                                                    },
                         "OptionalType" => {
                                             "can_be_empty" => 1,
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "type" => ","
                                                               },
                                                               {
                                                                 "set" => "type2",
                                                                 "type" => "rule",
                                                                 "value" => "TypeWithExtendedAttributes"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "Partial" => {
                                        "patterns" => [
                                                        [
                                                          {
                                                            "set_true" => "partial",
                                                            "type" => "partial"
                                                          },
                                                          {
                                                            "type" => "rule",
                                                            "value" => "PartialDefinition"
                                                          }
                                                        ]
                                                      ]
                                      },
                         "PartialDefinition" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "_PartialInterfaceOrPartialMixin"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "Namespace"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "PartialDictionary"
                                                                    }
                                                                  ]
                                                                ]
                                                },
                         "PartialDictionary" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "set_type" => "definition_type",
                                                                      "type" => "dictionary"
                                                                    },
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "_Name"
                                                                    },
                                                                    {
                                                                      "type" => "{"
                                                                    },
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "DictionaryMembers"
                                                                    },
                                                                    {
                                                                      "type" => "}"
                                                                    },
                                                                    {
                                                                      "type" => ";"
                                                                    }
                                                                  ]
                                                                ]
                                                },
                         "PartialInterfaceMember" => {
                                                       "patterns" => [
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "Const"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "Operation"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "Stringifier"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "StaticMember"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "Iterable"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "AsyncIterable"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ReadonlyMember"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ReadWriteAttribute"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ReadWriteMaplike"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ReadWriteSetlike"
                                                                         }
                                                                       ]
                                                                     ]
                                                     },
                         "PartialInterfaceMembers" => {
                                                        "patterns" => [
                                                                        [
                                                                          {
                                                                            "append" => "members",
                                                                            "multiple" => 1,
                                                                            "type" => "rule",
                                                                            "value" => "_PartialInterfaceMember"
                                                                          }
                                                                        ]
                                                                      ]
                                                      },
                         "PartialInterfaceOrPartialMixin" => {
                                                               "patterns" => [
                                                                               [
                                                                                 {
                                                                                   "type" => "rule",
                                                                                   "value" => "PartialInterfaceRest"
                                                                                 }
                                                                               ],
                                                                               [
                                                                                 {
                                                                                   "type" => "rule",
                                                                                   "value" => "MixinRest"
                                                                                 }
                                                                               ]
                                                                             ]
                                                             },
                         "PartialInterfaceRest" => {
                                                     "patterns" => [
                                                                     [
                                                                       {
                                                                         "type" => "rule",
                                                                         "value" => "_Name"
                                                                       },
                                                                       {
                                                                         "type" => "{"
                                                                       },
                                                                       {
                                                                         "type" => "rule",
                                                                         "value" => "PartialInterfaceMembers"
                                                                       },
                                                                       {
                                                                         "type" => "}"
                                                                       },
                                                                       {
                                                                         "type" => ";"
                                                                       }
                                                                     ]
                                                                   ]
                                                   },
                         "PrimitiveType" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "UnsignedIntegerType"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "UnrestrictedFloatType"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "type",
                                                                  "type" => "boolean"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "type",
                                                                  "type" => "byte"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "type",
                                                                  "type" => "octet"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "PromiseType" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "set_type" => "type_outer",
                                                                "type" => "Promise"
                                                              },
                                                              {
                                                                "type" => "<"
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "ReturnType"
                                                              },
                                                              {
                                                                "type" => ">"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "ReadOnly" => {
                                         "can_be_empty" => 1,
                                         "patterns" => [
                                                         [
                                                           {
                                                             "set_true" => "readonly",
                                                             "type" => "readonly"
                                                           }
                                                         ]
                                                       ]
                                       },
                         "ReadWriteAttribute" => {
                                                   "patterns" => [
                                                                   [
                                                                     {
                                                                       "set_true" => "inherit",
                                                                       "type" => "inherit"
                                                                     },
                                                                     {
                                                                       "type" => "rule",
                                                                       "value" => "_RWAttributeRest"
                                                                     }
                                                                   ],
                                                                   [
                                                                     {
                                                                       "type" => "rule",
                                                                       "value" => "AttributeRest"
                                                                     }
                                                                   ]
                                                                 ]
                                                 },
                         "ReadWriteMaplike" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "MaplikeRest"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "ReadWriteSetlike" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "SetlikeRest"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "ReadonlyMember" => {
                                               "patterns" => [
                                                               [
                                                                 {
                                                                   "set_true" => "readonly",
                                                                   "type" => "readonly"
                                                                 },
                                                                 {
                                                                   "type" => "rule",
                                                                   "value" => "ReadonlyMemberRest"
                                                                 }
                                                               ]
                                                             ]
                                             },
                         "ReadonlyMemberRest" => {
                                                   "patterns" => [
                                                                   [
                                                                     {
                                                                       "type" => "rule",
                                                                       "value" => "AttributeRest"
                                                                     }
                                                                   ],
                                                                   [
                                                                     {
                                                                       "type" => "rule",
                                                                       "value" => "MaplikeRest"
                                                                     }
                                                                   ],
                                                                   [
                                                                     {
                                                                       "type" => "rule",
                                                                       "value" => "SetlikeRest"
                                                                     }
                                                                   ]
                                                                 ]
                                                 },
                         "RecordType" => {
                                           "patterns" => [
                                                           [
                                                             {
                                                               "set_type" => "type_outer",
                                                               "type" => "record"
                                                             },
                                                             {
                                                               "type" => "<"
                                                             },
                                                             {
                                                               "set" => "type_key",
                                                               "type" => "rule",
                                                               "value" => "_RecordKeyType"
                                                             },
                                                             {
                                                               "type" => ","
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "TypeWithExtendedAttributes"
                                                             },
                                                             {
                                                               "type" => ">"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "RegularOperation" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "ReturnType"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "OperationRest"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "ReturnType" => {
                                           "patterns" => [
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Type"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_type" => "type",
                                                               "type" => "void"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "SetlikeRest" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "set_type" => "member_type",
                                                                "type" => "setlike"
                                                              },
                                                              {
                                                                "type" => "<"
                                                              },
                                                              {
                                                                "set" => "type1",
                                                                "type" => "rule",
                                                                "value" => "TypeWithExtendedAttributes"
                                                              },
                                                              {
                                                                "type" => ">"
                                                              },
                                                              {
                                                                "type" => ";"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "SingleType" => {
                                           "patterns" => [
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "DistinguishableType"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_type" => "type",
                                                               "type" => "any"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set" => "type_parameterized",
                                                               "type" => "rule",
                                                               "value" => "PromiseType"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "Special" => {
                                        "patterns" => [
                                                        [
                                                          {
                                                            "set_true" => "getter",
                                                            "type" => "getter"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "set_true" => "setter",
                                                            "type" => "setter"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "set_true" => "deleter",
                                                            "type" => "deleter"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "type" => "["
                                                          },
                                                          {
                                                            "type" => "other",
                                                            "value" => "*"
                                                          },
                                                          {
                                                            "type" => "identifier",
                                                            "value" => "id"
                                                          },
                                                          {
                                                            "type" => "="
                                                          },
                                                          {
                                                            "set_value" => "getter_id",
                                                            "type" => "string"
                                                          },
                                                          {
                                                            "type" => "other",
                                                            "value" => "*"
                                                          },
                                                          {
                                                            "type" => "]"
                                                          },
                                                          {
                                                            "set_true" => "getter",
                                                            "type" => "getter"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "type" => "["
                                                          },
                                                          {
                                                            "type" => "other",
                                                            "value" => "*"
                                                          },
                                                          {
                                                            "type" => "identifier",
                                                            "value" => "id"
                                                          },
                                                          {
                                                            "type" => "="
                                                          },
                                                          {
                                                            "set_value" => "setter_id",
                                                            "type" => "string"
                                                          },
                                                          {
                                                            "type" => "other",
                                                            "value" => "*"
                                                          },
                                                          {
                                                            "type" => "]"
                                                          },
                                                          {
                                                            "set_true" => "setter",
                                                            "type" => "setter"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "type" => "["
                                                          },
                                                          {
                                                            "type" => "other",
                                                            "value" => "*"
                                                          },
                                                          {
                                                            "type" => "identifier",
                                                            "value" => "id"
                                                          },
                                                          {
                                                            "type" => "="
                                                          },
                                                          {
                                                            "set_value" => "deleter_id",
                                                            "type" => "string"
                                                          },
                                                          {
                                                            "type" => "other",
                                                            "value" => "*"
                                                          },
                                                          {
                                                            "type" => "]"
                                                          },
                                                          {
                                                            "set_true" => "deleter",
                                                            "type" => "deleter"
                                                          }
                                                        ]
                                                      ]
                                      },
                         "SpecialOperation" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "Special"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "Specials"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "RegularOperation"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "Specials" => {
                                         "can_be_empty" => 1,
                                         "patterns" => [
                                                         [
                                                           {
                                                             "type" => "rule",
                                                             "value" => "Special"
                                                           },
                                                           {
                                                             "type" => "rule",
                                                             "value" => "Specials"
                                                           }
                                                         ]
                                                       ]
                                       },
                         "StaticMember" => {
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "set_true" => "static",
                                                                 "type" => "static"
                                                               },
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "StaticMemberRest"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "StaticMemberRest" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "AttributeRest"
                                                                   }
                                                                 ],
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "RegularOperation"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "StringType" => {
                                           "patterns" => [
                                                           [
                                                             {
                                                               "set_type" => "type",
                                                               "type" => "ByteString"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_type" => "type",
                                                               "type" => "DOMString"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_type" => "type",
                                                               "type" => "USVString"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "Stringifier" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "_IDInSpecDirective"
                                                              },
                                                              {
                                                                "set_true" => "stringifier",
                                                                "type" => "stringifier"
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "StringifierRest"
                                                              }
                                                            ]
                                                          ]
                                          },
                         "StringifierRest" => {
                                                "patterns" => [
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "AttributeRest"
                                                                  }
                                                                ],
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "RegularOperation"
                                                                  }
                                                                ],
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "_StringifierEnd"
                                                                  }
                                                                ]
                                                              ]
                                              },
                         "Type" => {
                                     "patterns" => [
                                                     [
                                                       {
                                                         "type" => "rule",
                                                         "value" => "SingleType"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "type" => "rule",
                                                         "value" => "UnionType"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "Null"
                                                       }
                                                     ]
                                                   ]
                                   },
                         "TypeWithExtendedAttributes" => {
                                                           "patterns" => [
                                                                           [
                                                                             {
                                                                               "type" => "rule",
                                                                               "value" => "Type"
                                                                             }
                                                                           ],
                                                                           [
                                                                             {
                                                                               "set" => "type",
                                                                               "type" => "rule",
                                                                               "value" => "_TypeWithExtendedAttributes"
                                                                             }
                                                                           ]
                                                                         ]
                                                         },
                         "Typedef" => {
                                        "patterns" => [
                                                        [
                                                          {
                                                            "set_type" => "definition_type",
                                                            "type" => "typedef"
                                                          },
                                                          {
                                                            "type" => "rule",
                                                            "value" => "TypeWithExtendedAttributes"
                                                          },
                                                          {
                                                            "type" => "rule",
                                                            "value" => "_Name"
                                                          },
                                                          {
                                                            "type" => ";"
                                                          }
                                                        ]
                                                      ]
                                      },
                         "UnionMemberType" => {
                                                "patterns" => [
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "ExtendedAttributeList"
                                                                  },
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "DistinguishableType"
                                                                  }
                                                                ],
                                                                [
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "UnionType"
                                                                  },
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "Null"
                                                                  }
                                                                ]
                                                              ]
                                              },
                         "UnionMemberTypes" => {
                                                 "can_be_empty" => 1,
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "or"
                                                                   },
                                                                   {
                                                                     "append" => "type_union",
                                                                     "type" => "rule",
                                                                     "value" => "UnionMemberType"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "UnionMemberTypes"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "UnionType" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "type" => "("
                                                            },
                                                            {
                                                              "append" => "type_union",
                                                              "type" => "rule",
                                                              "value" => "UnionMemberType"
                                                            },
                                                            {
                                                              "type" => "or"
                                                            },
                                                            {
                                                              "append" => "type_union",
                                                              "type" => "rule",
                                                              "value" => "UnionMemberType"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "UnionMemberTypes"
                                                            },
                                                            {
                                                              "type" => ")"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "UnrestrictedFloatType" => {
                                                      "patterns" => [
                                                                      [
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "_UnrestrictedFloat"
                                                                        }
                                                                      ],
                                                                      [
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "_UnrestrictedDouble"
                                                                        }
                                                                      ],
                                                                      [
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "FloatType"
                                                                        }
                                                                      ]
                                                                    ]
                                                    },
                         "UnsignedIntegerType" => {
                                                    "patterns" => [
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "_UnsignedShort"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "_UnsignedLongLong"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "_UnsignedLong"
                                                                      }
                                                                    ],
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "IntegerType"
                                                                      }
                                                                    ]
                                                                  ]
                                                  },
                         "_Argument" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "type" => "rule",
                                                              "value" => "ExtendedAttributeList"
                                                            },
                                                            {
                                                              "set_true" => "optional",
                                                              "type" => "optional"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "TypeWithExtendedAttributes"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "ArgumentName"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "Default"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "type" => "rule",
                                                              "value" => "Type"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "ArgumentName"
                                                            },
                                                            {
                                                              "type" => "="
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "DefaultValue"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "type" => "rule",
                                                              "value" => "ExtendedAttributeList"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "Type"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "Ellipsis"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "ArgumentName"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "_ArgumentNameKeyword" => {
                                                     "patterns" => [
                                                                     [
                                                                       {
                                                                         "type" => "rule",
                                                                         "value" => "_IDInSpecDirective"
                                                                       },
                                                                       {
                                                                         "type" => "rule",
                                                                         "value" => "ArgumentNameKeyword"
                                                                       }
                                                                     ]
                                                                   ]
                                                   },
                         "_AttributeNameKeyword" => {
                                                      "patterns" => [
                                                                      [
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "_IDInSpecDirective"
                                                                        },
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "AttributeNameKeyword"
                                                                        }
                                                                      ]
                                                                    ]
                                                    },
                         "_Callback" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "set_type" => "definition_type",
                                                              "type" => "callback"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "CallbackRest"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "set_true" => "callback",
                                                              "type" => "callback"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "_InterfaceInCallbackRestOrInterface"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "_CallbackInterfaceMember" => {
                                                         "patterns" => [
                                                                         [
                                                                           {
                                                                             "type" => "rule",
                                                                             "value" => "ExtendedAttributeList"
                                                                           },
                                                                           {
                                                                             "type" => "rule",
                                                                             "value" => "CallbackInterfaceMember"
                                                                           }
                                                                         ]
                                                                       ],
                                                         "set_index" => 1
                                                       },
                         "_Definition" => {
                                            "patterns" => [
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "ExtendedAttributeList"
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "Definition"
                                                              }
                                                            ]
                                                          ],
                                            "set_index" => 1
                                          },
                         "_DictionaryMember" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "DictionaryMember"
                                                                    }
                                                                  ]
                                                                ],
                                                  "set_fields" => [
                                                                    [
                                                                      "member_type",
                                                                      "dictionary_member"
                                                                    ]
                                                                  ],
                                                  "set_index" => 1
                                                },
                         "_EnumItem" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "type" => "rule",
                                                              "value" => "_IDInSpecDirective"
                                                            },
                                                            {
                                                              "set_value" => "value_string",
                                                              "type" => "string"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "_ExtendedAttributeList" => {
                                                       "patterns" => [
                                                                       [
                                                                         {
                                                                           "type" => "["
                                                                         },
                                                                         {
                                                                           "append" => "extended_attributes",
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttribute"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributes"
                                                                         },
                                                                         {
                                                                           "type" => "]"
                                                                         }
                                                                       ]
                                                                     ]
                                                     },
                         "_FrozenArrayType" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "set_type" => "type_outer",
                                                                     "type" => "FrozenArray"
                                                                   },
                                                                   {
                                                                     "type" => "<"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "TypeWithExtendedAttributes"
                                                                   },
                                                                   {
                                                                     "type" => ">"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "_IDInSpecDirective" => {
                                                   "can_be_empty" => 1,
                                                   "patterns" => [
                                                                   [
                                                                     {
                                                                       "type" => "["
                                                                     },
                                                                     {
                                                                       "type" => "other",
                                                                       "value" => "*"
                                                                     },
                                                                     {
                                                                       "type" => "identifier",
                                                                       "value" => "id"
                                                                     },
                                                                     {
                                                                       "type" => "="
                                                                     },
                                                                     {
                                                                       "set_value" => "id",
                                                                       "type" => "string"
                                                                     },
                                                                     {
                                                                       "type" => "other",
                                                                       "value" => "*"
                                                                     },
                                                                     {
                                                                       "type" => "]"
                                                                     }
                                                                   ]
                                                                 ]
                                                 },
                         "_IDInSpecDirectiveIgnored" => {
                                                          "can_be_empty" => 1,
                                                          "patterns" => [
                                                                          [
                                                                            {
                                                                              "type" => "["
                                                                            },
                                                                            {
                                                                              "type" => "other",
                                                                              "value" => "*"
                                                                            },
                                                                            {
                                                                              "type" => "identifier",
                                                                              "value" => "id"
                                                                            },
                                                                            {
                                                                              "type" => "="
                                                                            },
                                                                            {
                                                                              "type" => "string"
                                                                            },
                                                                            {
                                                                              "type" => "other",
                                                                              "value" => "*"
                                                                            },
                                                                            {
                                                                              "type" => "]"
                                                                            }
                                                                          ]
                                                                        ]
                                                        },
                         "_InterfaceInCallbackRestOrInterface" => {
                                                                    "patterns" => [
                                                                                    [
                                                                                      {
                                                                                        "set_type" => "definition_type",
                                                                                        "type" => "interface"
                                                                                      },
                                                                                      {
                                                                                        "type" => "rule",
                                                                                        "value" => "_Name"
                                                                                      },
                                                                                      {
                                                                                        "type" => "{"
                                                                                      },
                                                                                      {
                                                                                        "type" => "rule",
                                                                                        "value" => "CallbackInterfaceMembers"
                                                                                      },
                                                                                      {
                                                                                        "type" => "}"
                                                                                      },
                                                                                      {
                                                                                        "type" => ";"
                                                                                      }
                                                                                    ]
                                                                                  ]
                                                                  },
                         "_InterfaceMember" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "ExtendedAttributeList"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "InterfaceMember"
                                                                   }
                                                                 ]
                                                               ],
                                                 "set_index" => 1
                                               },
                         "_InterfaceOrMixin" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "set_type" => "definition_type",
                                                                      "type" => "interface"
                                                                    },
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "InterfaceOrMixin"
                                                                    }
                                                                  ]
                                                                ]
                                                },
                         "_Long" => {
                                      "patterns" => [
                                                      [
                                                        {
                                                          "set_type" => "type",
                                                          "type" => "long"
                                                        }
                                                      ]
                                                    ]
                                    },
                         "_LongLong" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "type" => "long"
                                                            },
                                                            {
                                                              "type" => "long"
                                                            }
                                                          ]
                                                        ],
                                          "set_fields" => [
                                                            [
                                                              "type",
                                                              "long long"
                                                            ]
                                                          ]
                                        },
                         "_MixinMember" => {
                                             "patterns" => [
                                                             [
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "ExtendedAttributeList"
                                                               },
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "MixinMember"
                                                               }
                                                             ]
                                                           ],
                                             "set_index" => 1
                                           },
                         "_Name" => {
                                      "patterns" => [
                                                      [
                                                        {
                                                          "type" => "rule",
                                                          "value" => "_IDInSpecDirective"
                                                        },
                                                        {
                                                          "remove_underscore" => 1,
                                                          "set_value" => "name",
                                                          "type" => "identifier"
                                                        }
                                                      ]
                                                    ]
                                    },
                         "_NamespaceMember" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "ExtendedAttributeList"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "NamespaceMember"
                                                                   }
                                                                 ]
                                                               ],
                                                 "set_index" => 1
                                               },
                         "_NamespaceOperation" => {
                                                    "patterns" => [
                                                                    [
                                                                      {
                                                                        "type" => "rule",
                                                                        "value" => "RegularOperation"
                                                                      }
                                                                    ]
                                                                  ],
                                                    "set_fields" => [
                                                                      [
                                                                        "member_type",
                                                                        "operation"
                                                                      ]
                                                                    ]
                                                  },
                         "_ObsoleteDirective" => {
                                                   "can_be_empty" => 1,
                                                   "patterns" => [
                                                                   [
                                                                     {
                                                                       "type" => "["
                                                                     },
                                                                     {
                                                                       "type" => "other",
                                                                       "value" => "*"
                                                                     },
                                                                     {
                                                                       "set_true" => "obsolete",
                                                                       "type" => "identifier",
                                                                       "value" => "obsolete"
                                                                     },
                                                                     {
                                                                       "type" => "other",
                                                                       "value" => "*"
                                                                     },
                                                                     {
                                                                       "type" => "]"
                                                                     }
                                                                   ]
                                                                 ]
                                                 },
                         "_OperationNameKeyword" => {
                                                      "patterns" => [
                                                                      [
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "_IDInSpecDirective"
                                                                        },
                                                                        {
                                                                          "type" => "rule",
                                                                          "value" => "OperationNameKeyword"
                                                                        }
                                                                      ]
                                                                    ]
                                                    },
                         "_PartialInterfaceMember" => {
                                                        "patterns" => [
                                                                        [
                                                                          {
                                                                            "type" => "rule",
                                                                            "value" => "ExtendedAttributeList"
                                                                          },
                                                                          {
                                                                            "type" => "rule",
                                                                            "value" => "PartialInterfaceMember"
                                                                          }
                                                                        ]
                                                                      ],
                                                        "set_index" => 1
                                                      },
                         "_PartialInterfaceOrPartialMixin" => {
                                                                "patterns" => [
                                                                                [
                                                                                  {
                                                                                    "set_type" => "definition_type",
                                                                                    "type" => "interface"
                                                                                  },
                                                                                  {
                                                                                    "type" => "rule",
                                                                                    "value" => "PartialInterfaceOrPartialMixin"
                                                                                  }
                                                                                ]
                                                                              ]
                                                              },
                         "_RWAttributeRest" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "set_type" => "member_type",
                                                                     "type" => "attribute"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "TypeWithExtendedAttributes"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "AttributeName"
                                                                   },
                                                                   {
                                                                     "type" => ";"
                                                                   }
                                                                 ]
                                                               ]
                                               },
                         "_ReadOnlyAttributeRest" => {
                                                       "patterns" => [
                                                                       [
                                                                         {
                                                                           "set_true" => "readonly",
                                                                           "type" => "readonly"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "AttributeRest"
                                                                         }
                                                                       ]
                                                                     ]
                                                     },
                         "_RecordKeyType" => {
                                               "patterns" => [
                                                               [
                                                                 {
                                                                   "type" => "rule",
                                                                   "value" => "StringType"
                                                                 }
                                                               ]
                                                             ]
                                             },
                         "_SequenceType" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "set_type" => "type_outer",
                                                                  "type" => "sequence"
                                                                },
                                                                {
                                                                  "type" => "<"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "TypeWithExtendedAttributes"
                                                                },
                                                                {
                                                                  "type" => ">"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "_SpecDirective" => {
                                               "can_be_empty" => 1,
                                               "patterns" => [
                                                               [
                                                                 {
                                                                   "type" => "["
                                                                 },
                                                                 {
                                                                   "type" => "other",
                                                                   "value" => "*"
                                                                 },
                                                                 {
                                                                   "type" => "identifier",
                                                                   "value" => "spec"
                                                                 },
                                                                 {
                                                                   "type" => "="
                                                                 },
                                                                 {
                                                                   "set_value" => "spec",
                                                                   "type" => "identifier"
                                                                 },
                                                                 {
                                                                   "type" => "other",
                                                                   "value" => "*"
                                                                 },
                                                                 {
                                                                   "type" => "]"
                                                                 }
                                                               ]
                                                             ]
                                             },
                         "_StringifierEnd" => {
                                                "ensure_arrayref" => "arguments",
                                                "patterns" => [
                                                                [
                                                                  {
                                                                    "type" => ";"
                                                                  }
                                                                ]
                                                              ],
                                                "set_fields" => [
                                                                  [
                                                                    "member_type",
                                                                    "operation"
                                                                  ],
                                                                  [
                                                                    "type",
                                                                    "DOMString"
                                                                  ]
                                                                ]
                                              },
                         "_SuperName" => {
                                           "patterns" => [
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "_IDInSpecDirectiveIgnored"
                                                             },
                                                             {
                                                               "set_value" => "super_name",
                                                               "type" => "identifier"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "_TypeWithExtendedAttributes" => {
                                                            "patterns" => [
                                                                            [
                                                                              {
                                                                                "type" => "rule",
                                                                                "value" => "_ExtendedAttributeList"
                                                                              },
                                                                              {
                                                                                "type" => "rule",
                                                                                "value" => "SingleType"
                                                                              }
                                                                            ],
                                                                            [
                                                                              {
                                                                                "type" => "rule",
                                                                                "value" => "_ExtendedAttributeList"
                                                                              },
                                                                              {
                                                                                "type" => "rule",
                                                                                "value" => "UnionType"
                                                                              },
                                                                              {
                                                                                "type" => "rule",
                                                                                "value" => "Null"
                                                                              }
                                                                            ]
                                                                          ]
                                                          },
                         "_UnrestrictedDouble" => {
                                                    "patterns" => [
                                                                    [
                                                                      {
                                                                        "type" => "unrestricted"
                                                                      },
                                                                      {
                                                                        "type" => "double"
                                                                      }
                                                                    ]
                                                                  ],
                                                    "set_fields" => [
                                                                      [
                                                                        "type",
                                                                        "unrestricted double"
                                                                      ]
                                                                    ]
                                                  },
                         "_UnrestrictedFloat" => {
                                                   "patterns" => [
                                                                   [
                                                                     {
                                                                       "type" => "unrestricted"
                                                                     },
                                                                     {
                                                                       "type" => "float"
                                                                     }
                                                                   ]
                                                                 ],
                                                   "set_fields" => [
                                                                     [
                                                                       "type",
                                                                       "unrestricted float"
                                                                     ]
                                                                   ]
                                                 },
                         "_UnsignedLong" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "type" => "unsigned"
                                                                },
                                                                {
                                                                  "type" => "long"
                                                                }
                                                              ]
                                                            ],
                                              "set_fields" => [
                                                                [
                                                                  "type",
                                                                  "unsigned long"
                                                                ]
                                                              ]
                                            },
                         "_UnsignedLongLong" => {
                                                  "patterns" => [
                                                                  [
                                                                    {
                                                                      "type" => "unsigned"
                                                                    },
                                                                    {
                                                                      "type" => "long"
                                                                    },
                                                                    {
                                                                      "type" => "long"
                                                                    }
                                                                  ]
                                                                ],
                                                  "set_fields" => [
                                                                    [
                                                                      "type",
                                                                      "unsigned long long"
                                                                    ]
                                                                  ]
                                                },
                         "_UnsignedShort" => {
                                               "patterns" => [
                                                               [
                                                                 {
                                                                   "type" => "unsigned"
                                                                 },
                                                                 {
                                                                   "type" => "short"
                                                                 }
                                                               ]
                                                             ],
                                               "set_fields" => [
                                                                 [
                                                                   "type",
                                                                   "unsigned short"
                                                                 ]
                                                               ]
                                             }
                       },
          "keyword_tokens" => {
                                "ArrayBuffer" => {},
                                "ByteString" => {},
                                "DOMString" => {},
                                "DataView" => {},
                                "Date" => {},
                                "Float32Array" => {},
                                "Float64Array" => {},
                                "FrozenArray" => {},
                                "Infinity" => {},
                                "Int16Array" => {},
                                "Int32Array" => {},
                                "Int8Array" => {},
                                "NaN" => {},
                                "Promise" => {},
                                "RegExp" => {},
                                "USVString" => {},
                                "Uint16Array" => {},
                                "Uint32Array" => {},
                                "Uint8Array" => {},
                                "Uint8ClampedArray" => {},
                                "any" => {},
                                "async" => {
                                             "argument_name" => 1,
                                             "attribute_name" => 1
                                           },
                                "attribute" => {
                                                 "argument_name" => 1
                                               },
                                "boolean" => {},
                                "byte" => {},
                                "callback" => {
                                                "argument_name" => 1
                                              },
                                "const" => {
                                             "argument_name" => 1
                                           },
                                "constructor" => {
                                                   "argument_name" => 1
                                                 },
                                "deleter" => {
                                               "argument_name" => 1
                                             },
                                "dictionary" => {
                                                  "argument_name" => 1
                                                },
                                "double" => {},
                                "enum" => {
                                            "argument_name" => 1
                                          },
                                "false" => {},
                                "float" => {},
                                "getter" => {
                                              "argument_name" => 1
                                            },
                                "includes" => {
                                                "argument_name" => 1,
                                                "operation_name" => 1
                                              },
                                "inherit" => {
                                               "argument_name" => 1
                                             },
                                "interface" => {
                                                 "argument_name" => 1
                                               },
                                "iterable" => {
                                                "argument_name" => 1
                                              },
                                "long" => {},
                                "maplike" => {
                                               "argument_name" => 1
                                             },
                                "mixin" => {},
                                "namespace" => {
                                                 "argument_name" => 1
                                               },
                                "null" => {},
                                "object" => {},
                                "octet" => {},
                                "optional" => {},
                                "or" => {},
                                "partial" => {
                                               "argument_name" => 1
                                             },
                                "readonly" => {},
                                "record" => {
                                              "argument_name" => 1
                                            },
                                "required" => {
                                                "argument_name" => 1,
                                                "attribute_name" => 1
                                              },
                                "sequence" => {},
                                "setlike" => {
                                               "argument_name" => 1
                                             },
                                "setter" => {
                                              "argument_name" => 1
                                            },
                                "short" => {},
                                "static" => {
                                              "argument_name" => 1
                                            },
                                "stringifier" => {
                                                   "argument_name" => 1
                                                 },
                                "true" => {},
                                "typedef" => {
                                               "argument_name" => 1
                                             },
                                "unrestricted" => {
                                                    "argument_name" => 1
                                                  },
                                "unsigned" => {},
                                "void" => {}
                              },
          "other_tokens" => {
                              "(" => 1,
                              ")" => 1,
                              "," => 1,
                              "-" => 1,
                              "." => 1,
                              ":" => 1,
                              ";" => 1,
                              "<" => 1,
                              "=" => 1,
                              ">" => 1,
                              "?" => 1,
                              "[" => 1,
                              "]" => 1,
                              "{" => 1,
                              "}" => 1
                            },
          "reserved" => {
                          "argument" => {
                                          "constructor" => 1,
                                          "iterator" => 1,
                                          "toString" => 1
                                        },
                          "attribute" => {
                                           "constructor" => 1,
                                           "iterator" => 1,
                                           "prototype" => 1,
                                           "toString" => 1
                                         },
                          "callback" => {
                                          "constructor" => 1,
                                          "iterator" => 1,
                                          "toString" => 1
                                        },
                          "callback_interface" => {
                                                    "constructor" => 1,
                                                    "iterator" => 1,
                                                    "toString" => 1
                                                  },
                          "const" => {
                                       "constructor" => 1,
                                       "iterator" => 1,
                                       "prototype" => 1,
                                       "toString" => 1
                                     },
                          "dictionary" => {
                                            "constructor" => 1,
                                            "iterator" => 1,
                                            "toString" => 1
                                          },
                          "dictionary_member" => {
                                                   "constructor" => 1,
                                                   "iterator" => 1,
                                                   "toString" => 1
                                                 },
                          "enum" => {
                                      "constructor" => 1,
                                      "iterator" => 1,
                                      "toString" => 1
                                    },
                          "interface" => {
                                           "constructor" => 1,
                                           "iterator" => 1,
                                           "toString" => 1
                                         },
                          "interface_mixin" => {
                                                 "constructor" => 1,
                                                 "iterator" => 1,
                                                 "toString" => 1
                                               },
                          "operation" => {
                                           "constructor" => 1,
                                           "iterator" => 1,
                                           "prototype" => 1,
                                           "toString" => 1
                                         },
                          "partial_dictionary" => {
                                                    "constructor" => 1,
                                                    "iterator" => 1,
                                                    "toString" => 1
                                                  },
                          "partial_interface" => {
                                                   "constructor" => 1,
                                                   "iterator" => 1,
                                                   "toString" => 1
                                                 },
                          "partial_interface_mixin" => {
                                                         "constructor" => 1,
                                                         "iterator" => 1,
                                                         "toString" => 1
                                                       },
                          "static_attribute" => {
                                                  "constructor" => 1,
                                                  "iterator" => 1,
                                                  "prototype" => 1,
                                                  "toString" => 1
                                                },
                          "static_operation" => {
                                                  "constructor" => 1,
                                                  "iterator" => 1,
                                                  "prototype" => 1,
                                                  "toString" => 1
                                                },
                          "typedef" => {
                                         "constructor" => 1,
                                         "iterator" => 1,
                                         "toString" => 1
                                       }
                        },
          "xattr_args" => {
                            "AllowShared" => {
                                               "no" => 1
                                             },
                            "CEReactions" => {
                                               "no" => 1
                                             },
                            "Clamp" => {
                                         "no" => 1
                                       },
                            "Default" => {
                                           "no" => 1
                                         },
                            "EnforceRange" => {
                                                "no" => 1
                                              },
                            "Exposed" => {
                                           "id" => 1,
                                           "id_list" => 1
                                         },
                            "Global" => {
                                          "id" => 1,
                                          "id_list" => 1,
                                          "no" => 1
                                        },
                            "HTMLConstructor" => {
                                                   "no" => 1
                                                 },
                            "LegacyArrayClass" => {
                                                    "no" => 1
                                                  },
                            "LegacyUnenumerableNamedProperties" => {
                                                                     "no" => 1
                                                                   },
                            "LegacyWindowAlias" => {
                                                     "id" => 1,
                                                     "id_list" => 1
                                                   },
                            "LenientSetter" => {
                                                 "no" => 1
                                               },
                            "LenientThis" => {
                                               "no" => 1
                                             },
                            "NamedConstructor" => {
                                                    "id" => 1,
                                                    "named_args" => 1
                                                  },
                            "NewObject" => {
                                             "no" => 1
                                           },
                            "NoInterfaceObject" => {
                                                     "no" => 1
                                                   },
                            "OverrideBuiltins" => {
                                                    "no" => 1
                                                  },
                            "PutForwards" => {
                                               "id" => 1
                                             },
                            "Replaceable" => {
                                               "no" => 1
                                             },
                            "SameObject" => {
                                              "no" => 1
                                            },
                            "SecureContext" => {
                                                 "no" => 1
                                               },
                            "Serializable" => {
                                                "no" => 1
                                              },
                            "Transferable" => {
                                                "no" => 1
                                              },
                            "TreatNonObjectAsNull" => {
                                                        "no" => 1
                                                      },
                            "TreatNullAs" => {
                                               "id" => 1
                                             },
                            "Unforgeable" => {
                                               "no" => 1
                                             },
                            "Unscopable" => {
                                              "no" => 1
                                            }
                          },
          "xattr_disallowed" => [
                                  [
                                    "Clamp",
                                    "EnforceRange"
                                  ],
                                  [
                                    "Global",
                                    "NamedConstructor"
                                  ],
                                  [
                                    "Global",
                                    "OverrideBuiltins"
                                  ],
                                  [
                                    "HTMLConstructor",
                                    "NoInterfaceObject"
                                  ],
                                  [
                                    "LegacyWindowAlias",
                                    "NoInterfaceObject"
                                  ],
                                  [
                                    "LenientSetter",
                                    "PutForwards"
                                  ],
                                  [
                                    "LenientSetter",
                                    "Replaceable"
                                  ],
                                  [
                                    "PutForwards",
                                    "Replaceable"
                                  ]
                                ],
          "xattr_multiple" => {
                                "NamedConstructor" => 1
                              }
        };

