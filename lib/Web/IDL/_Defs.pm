$Web::IDL::_Defs = {
          "grammer" => {
                       "Argument" => {
                                     "patterns" => [
                                                   [
                                                     {
                                                       "type" => "rule",
                                                       "value" => "ExtendedAttributeList"
                                                     },
                                                     {
                                                       "type" => "rule",
                                                       "value" => "OptionalOrRequiredArgument"
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
                                                           "value" => "ArgumentNameKeyword"
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
                                                                  "type" => "creator"
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
                                                                  "type" => "attribute"
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
                                                                  "type" => "interface"
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
                                                                  "type" => "deleter"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "name",
                                                                  "type" => "legacycaller"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "name",
                                                                  "type" => "extends"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "name",
                                                                  "type" => "serializer"
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
                                                                  "type" => "callback"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "name",
                                                                  "type" => "class"
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
                                                                  "type" => "partial"
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
                                                                  "type" => "unrestricted"
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
                                                                  "type" => "stringifier"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "name",
                                                                  "type" => "implements"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "name",
                                                                  "type" => "exception"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_type" => "name",
                                                                  "type" => "setter"
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
                       "Attribute" => {
                                      "patterns" => [
                                                    [
                                                      {
                                                        "type" => "rule",
                                                        "value" => "Inherit"
                                                      },
                                                      {
                                                        "type" => "rule",
                                                        "value" => "AttributeRest"
                                                      }
                                                    ]
                                                  ]
                                    },
                       "AttributeOrOperationOrIterator" => {
                                                           "patterns" => [
                                                                         [
                                                                           {
                                                                             "type" => "rule",
                                                                             "value" => "Serializer"
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
                                                                             "value" => "Attribute"
                                                                           }
                                                                         ],
                                                                         [
                                                                           {
                                                                             "type" => "rule",
                                                                             "value" => "OperationOrIterator"
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
                                                            "set_type" => "member_type",
                                                            "type" => "attribute"
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
                                                            "type" => ";"
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
                       "CallbackOrInterface" => {
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
                                                                  "value" => "Interface"
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
                       "CallbackRestOrInterface" => {
                                                    "patterns" => [
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "CallbackRest"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "Interface"
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
                                                      },
                                                      {
                                                        "type" => "rule",
                                                        "value" => "Null"
                                                      }
                                                    ],
                                                    [
                                                      {
                                                        "set_value" => "type_name",
                                                        "type" => "identifier"
                                                      },
                                                      {
                                                        "type" => "rule",
                                                        "value" => "Null"
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
                                                     ],
                                                     [
                                                       {
                                                         "set_type" => "value",
                                                         "type" => "null"
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
                                                       ]
                                                     ]
                                       },
                       "Definition" => {
                                       "patterns" => [
                                                     [
                                                       {
                                                         "type" => "rule",
                                                         "value" => "CallbackOrInterface"
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
                                                         "value" => "Exception"
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
                                                         "value" => "ImplementsStatement"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "type" => "rule",
                                                         "value" => "_Class"
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
                       "Exception" => {
                                      "patterns" => [
                                                    [
                                                      {
                                                        "set_type" => "definition_type",
                                                        "type" => "exception"
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
                                                        "value" => "ExceptionMembers"
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
                       "ExceptionField" => {
                                           "patterns" => [
                                                         [
                                                           {
                                                             "type" => "rule",
                                                             "value" => "Type"
                                                           },
                                                           {
                                                             "type" => "rule",
                                                             "value" => "_Name"
                                                           },
                                                           {
                                                             "type" => ";"
                                                           }
                                                         ]
                                                       ],
                                           "set_fields" => [
                                                           [
                                                             "member_type",
                                                             "field"
                                                           ]
                                                         ]
                                         },
                       "ExceptionMember" => {
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
                                                              "value" => "ExceptionField"
                                                            }
                                                          ]
                                                        ]
                                          },
                       "ExceptionMembers" => {
                                             "patterns" => [
                                                           [
                                                             {
                                                               "append" => "members",
                                                               "multiple" => 1,
                                                               "type" => "rule",
                                                               "value" => "_ExceptionMember"
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
                                                                "value" => "ExtendedAttributeTypePair"
                                                              }
                                                            ],
                                                            [
                                                              {
                                                                "set_value" => "name",
                                                                "type" => "identifier",
                                                                "value" => "PutForwards"
                                                              },
                                                              {
                                                                "type" => "="
                                                              },
                                                              {
                                                                "append_value" => "value_names",
                                                                "next_is_not" => {
                                                                                 "(" => 1,
                                                                                 "=" => 1
                                                                               },
                                                                "type" => "identifier"
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
                                                                "value" => "ObsExtendedAttributeIdentList"
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
                       "ExtendedAttributeNamedArgList" => {
                                                          "patterns" => [
                                                                        [
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
                       "ExtendedAttributeTypePair" => {
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
                                                                        "append" => "value_types",
                                                                        "type" => "rule",
                                                                        "value" => "Type"
                                                                      },
                                                                      {
                                                                        "type" => ","
                                                                      },
                                                                      {
                                                                        "append" => "value_types",
                                                                        "type" => "rule",
                                                                        "value" => "Type"
                                                                      },
                                                                      {
                                                                        "type" => ")"
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
                       "ImplementsStatement" => {
                                                "patterns" => [
                                                              [
                                                                {
                                                                  "set_value" => "name",
                                                                  "type" => "identifier"
                                                                },
                                                                {
                                                                  "set_type" => "definition_type",
                                                                  "type" => "implements"
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
                       "Interface" => {
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
                       "InterfaceMember" => {
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
                                                              "value" => "AttributeOrOperationOrIterator"
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
                       "IteratorRest" => {
                                         "patterns" => [
                                                       [
                                                         {
                                                           "set_type" => "member_type",
                                                           "type" => "iterator"
                                                         },
                                                         {
                                                           "type" => "rule",
                                                           "value" => "OptionalIteratorInterface"
                                                         },
                                                         {
                                                           "type" => ";"
                                                         }
                                                       ],
                                                       [
                                                         {
                                                           "type" => "rule",
                                                           "value" => "_IteratorObject"
                                                         }
                                                       ]
                                                     ]
                                       },
                       "NonAnyType" => {
                                       "patterns" => [
                                                     [
                                                       {
                                                         "type" => "rule",
                                                         "value" => "PrimitiveType"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffix"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set_type" => "type",
                                                         "type" => "ByteString"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffix"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set_type" => "type",
                                                         "type" => "DOMString"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffix"
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
                                                         "value" => "TypeSuffix"
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
                                                         "value" => "TypeSuffix"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set_type" => "type",
                                                         "type" => "Date"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffix"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set_type" => "type",
                                                         "type" => "RegExp"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffix"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set" => "type_parameterized",
                                                         "type" => "rule",
                                                         "value" => "_PromiseType"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "Null"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set_type" => "type",
                                                         "type" => "Promise"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffix"
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
                       "ObsExtendedAttributeIdentList" => {
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
                                                                            "next_is_not" => {
                                                                                             "(" => 1,
                                                                                             "=" => 1
                                                                                           },
                                                                            "type" => "rule",
                                                                            "value" => "IdentifierList"
                                                                          }
                                                                        ]
                                                                      ]
                                                        },
                       "OperationIteratorInterfaceOrObject" => {
                                                               "patterns" => [
                                                                             [
                                                                               {
                                                                                 "type" => "rule",
                                                                                 "value" => "OptionalIteratorInterface"
                                                                               }
                                                                             ],
                                                                             [
                                                                               {
                                                                                 "set_true" => "object",
                                                                                 "type" => "object"
                                                                               }
                                                                             ]
                                                                           ]
                                                             },
                       "OperationOrIterator" => {
                                                "patterns" => [
                                                              [
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "ReturnType"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "OperationOrIteratorRest"
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
                       "OperationOrIteratorRest" => {
                                                    "patterns" => [
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "IteratorRest"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "OperationRest"
                                                                    }
                                                                  ]
                                                                ]
                                                  },
                       "OperationRest" => {
                                          "patterns" => [
                                                        [
                                                          {
                                                            "type" => "rule",
                                                            "value" => "OptionalIdentifier"
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
                       "OptionalIdentifier" => {
                                               "can_be_empty" => 1,
                                               "patterns" => [
                                                             [
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "_Name"
                                                               }
                                                             ]
                                                           ]
                                             },
                       "OptionalIteratorInterface" => {
                                                      "can_be_empty" => 1,
                                                      "patterns" => [
                                                                    [
                                                                      {
                                                                        "type" => "="
                                                                      },
                                                                      {
                                                                        "set_value" => "value_name",
                                                                        "type" => "identifier"
                                                                      }
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
                       "OptionalOrRequiredArgument" => {
                                                       "patterns" => [
                                                                     [
                                                                       {
                                                                         "set_true" => "optional",
                                                                         "type" => "optional"
                                                                       },
                                                                       {
                                                                         "type" => "rule",
                                                                         "value" => "Type"
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
                                                                "value" => "PartialInterface"
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
                       "PartialInterface" => {
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
                       "SerializationPattern" => {
                                                 "patterns" => [
                                                               [
                                                                 {
                                                                   "type" => "{"
                                                                 },
                                                                 {
                                                                   "set" => "value_map",
                                                                   "type" => "rule",
                                                                   "value" => "SerializationPatternMap"
                                                                 },
                                                                 {
                                                                   "type" => "}"
                                                                 }
                                                               ],
                                                               [
                                                                 {
                                                                   "type" => "["
                                                                 },
                                                                 {
                                                                   "set" => "value_list",
                                                                   "type" => "rule",
                                                                   "value" => "SerializationPatternList"
                                                                 },
                                                                 {
                                                                   "type" => "]"
                                                                 }
                                                               ],
                                                               [
                                                                 {
                                                                   "set_value" => "value_name",
                                                                   "type" => "identifier"
                                                                 }
                                                               ]
                                                             ]
                                               },
                       "SerializationPatternList" => {
                                                     "can_be_empty" => 1,
                                                     "ensure_arrayref" => "value_names",
                                                     "patterns" => [
                                                                   [
                                                                     {
                                                                       "set_true" => "getter",
                                                                       "type" => "getter"
                                                                     }
                                                                   ],
                                                                   [
                                                                     {
                                                                       "append_value" => "value_names",
                                                                       "type" => "identifier"
                                                                     },
                                                                     {
                                                                       "type" => "rule",
                                                                       "value" => "Identifiers"
                                                                     }
                                                                   ]
                                                                 ]
                                                   },
                       "SerializationPatternMap" => {
                                                    "can_be_empty" => 1,
                                                    "ensure_arrayref" => "value_names",
                                                    "patterns" => [
                                                                  [
                                                                    {
                                                                      "set_true" => "getter",
                                                                      "type" => "getter"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_true" => "attribute",
                                                                      "type" => "attribute"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_true" => "inherit",
                                                                      "type" => "inherit"
                                                                    },
                                                                    {
                                                                      "type" => ","
                                                                    },
                                                                    {
                                                                      "set_true" => "attribute",
                                                                      "type" => "attribute"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "set_true" => "inherit",
                                                                      "type" => "inherit"
                                                                    },
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "Identifiers"
                                                                    }
                                                                  ],
                                                                  [
                                                                    {
                                                                      "append_value" => "value_names",
                                                                      "type" => "identifier"
                                                                    },
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "Identifiers"
                                                                    }
                                                                  ]
                                                                ]
                                                  },
                       "Serializer" => {
                                       "patterns" => [
                                                     [
                                                       {
                                                         "type" => "rule",
                                                         "value" => "_SerializerOperation"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "type" => "rule",
                                                         "value" => "_Serializer"
                                                       }
                                                     ]
                                                   ]
                                     },
                       "SerializerRest" => {
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
                                                         ],
                                                         [
                                                           {
                                                             "type" => "="
                                                           },
                                                           {
                                                             "type" => "rule",
                                                             "value" => "SerializationPattern"
                                                           }
                                                         ],
                                                         [
                                                           {
                                                             "type" => "rule",
                                                             "value" => "_SerializerEnd"
                                                           }
                                                         ]
                                                       ]
                                         },
                       "SingleType" => {
                                       "patterns" => [
                                                     [
                                                       {
                                                         "type" => "rule",
                                                         "value" => "NonAnyType"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set_type" => "type",
                                                         "type" => "any"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffixStartingWithArray"
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
                                                      "set_true" => "creator",
                                                      "type" => "creator"
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
                                                      "set_true" => "legacycaller",
                                                      "type" => "legacycaller"
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
                                                      "set_value" => "creator_id",
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
                                                      "set_true" => "creator",
                                                      "type" => "creator"
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
                                                      "set_value" => "legacycaller_id",
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
                                                      "set_true" => "legacycaller",
                                                      "type" => "legacycaller"
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
                                                               "value" => "ReturnType"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "OperationRest"
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
                                                               "value" => "ReturnType"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "OperationRest"
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
                                                              "value" => "ReturnType"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "OperationRest"
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
                                                   "value" => "TypeSuffix"
                                                 }
                                               ]
                                             ]
                               },
                       "TypeSuffix" => {
                                       "can_be_empty" => 1,
                                       "patterns" => [
                                                     [
                                                       {
                                                         "set" => "type_array",
                                                         "type" => "rule",
                                                         "value" => "_TypeArray"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set_true" => "type_nullable",
                                                         "type" => "?"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffixStartingWithArray"
                                                       }
                                                     ]
                                                   ]
                                     },
                       "TypeSuffixStartingWithArray" => {
                                                        "can_be_empty" => 1,
                                                        "patterns" => [
                                                                      [
                                                                        {
                                                                          "set" => "type_array",
                                                                          "type" => "rule",
                                                                          "value" => "_TypeArray"
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
                                                      "value" => "Type"
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
                                                              "value" => "NonAnyType"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "type" => "rule",
                                                              "value" => "UnionType"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "TypeSuffix"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "set_type" => "type",
                                                              "type" => "any"
                                                            },
                                                            {
                                                              "set" => "type_array",
                                                              "type" => "rule",
                                                              "value" => "_TypeArray"
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
                                                        "value" => "Interface"
                                                      }
                                                    ]
                                                  ]
                                    },
                       "_Class" => {
                                   "patterns" => [
                                                 [
                                                   {
                                                     "set_type" => "definition_type",
                                                     "type" => "class"
                                                   },
                                                   {
                                                     "type" => "rule",
                                                     "value" => "_Name"
                                                   },
                                                   {
                                                     "type" => "rule",
                                                     "value" => "_ClassInheritance"
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
                       "_ClassInheritance" => {
                                              "can_be_empty" => 1,
                                              "patterns" => [
                                                            [
                                                              {
                                                                "type" => "extends"
                                                              },
                                                              {
                                                                "type" => "rule",
                                                                "value" => "_SuperName"
                                                              }
                                                            ]
                                                          ]
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
                                                                "value" => "ExtendedAttributeList"
                                                              },
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
                       "_ExceptionMember" => {
                                             "patterns" => [
                                                           [
                                                             {
                                                               "type" => "rule",
                                                               "value" => "ExtendedAttributeList"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "ExceptionMember"
                                                             }
                                                           ]
                                                         ],
                                             "set_index" => 1
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
                       "_IteratorObject" => {
                                            "patterns" => [
                                                          [
                                                            {
                                                              "type" => "iterator"
                                                            },
                                                            {
                                                              "type" => "object"
                                                            },
                                                            {
                                                              "type" => ";"
                                                            }
                                                          ]
                                                        ],
                                            "set_fields" => [
                                                            [
                                                              "member_type",
                                                              "iterator_object"
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
                       "_PromiseType" => {
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
                                                           "value" => "Type"
                                                         },
                                                         {
                                                           "type" => ">"
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
                                                            "value" => "Type"
                                                          },
                                                          {
                                                            "type" => ">"
                                                          }
                                                        ]
                                                      ]
                                        },
                       "_Serializer" => {
                                        "patterns" => [
                                                      [
                                                        {
                                                          "type" => "rule",
                                                          "value" => "_IDInSpecDirective"
                                                        },
                                                        {
                                                          "set_type" => "member_type",
                                                          "type" => "serializer"
                                                        },
                                                        {
                                                          "type" => "="
                                                        },
                                                        {
                                                          "type" => "rule",
                                                          "value" => "SerializationPattern"
                                                        },
                                                        {
                                                          "type" => ";"
                                                        }
                                                      ],
                                                      [
                                                        {
                                                          "type" => "rule",
                                                          "value" => "_IDInSpecDirective"
                                                        },
                                                        {
                                                          "set_type" => "member_type",
                                                          "type" => "serializer"
                                                        },
                                                        {
                                                          "type" => ";"
                                                        }
                                                      ]
                                                    ]
                                      },
                       "_SerializerOperation" => {
                                                 "patterns" => [
                                                               [
                                                                 {
                                                                   "set_true" => "serializer",
                                                                   "type" => "serializer"
                                                                 },
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
                       "_TypeArray" => {
                                       "patterns" => [
                                                     [
                                                       {
                                                         "type" => "["
                                                       },
                                                       {
                                                         "type" => "]"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffix"
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
                              "ByteString" => {},
                              "DOMString" => {},
                              "Date" => {},
                              "Infinity" => {},
                              "NaN" => {},
                              "Promise" => {},
                              "RegExp" => {},
                              "any" => {},
                              "attribute" => {
                                             "argument_name" => 1
                                           },
                              "boolean" => {},
                              "byte" => {},
                              "callback" => {
                                            "argument_name" => 1
                                          },
                              "class" => {
                                         "argument_name" => 1
                                       },
                              "const" => {
                                         "argument_name" => 1
                                       },
                              "creator" => {
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
                              "exception" => {
                                             "argument_name" => 1
                                           },
                              "extends" => {
                                           "argument_name" => 1
                                         },
                              "false" => {},
                              "float" => {},
                              "getter" => {
                                          "argument_name" => 1
                                        },
                              "implements" => {
                                              "argument_name" => 1
                                            },
                              "inherit" => {
                                           "argument_name" => 1
                                         },
                              "interface" => {
                                             "argument_name" => 1
                                           },
                              "iterator" => {},
                              "legacycaller" => {
                                                "argument_name" => 1
                                              },
                              "long" => {},
                              "null" => {},
                              "object" => {},
                              "octet" => {},
                              "optional" => {},
                              "or" => {},
                              "partial" => {
                                           "argument_name" => 1
                                         },
                              "readonly" => {},
                              "sequence" => {},
                              "serializer" => {
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
                          }
        };

