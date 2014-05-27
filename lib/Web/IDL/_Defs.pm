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
                                                           "remove_underscore" => 1,
                                                           "set_value" => "name",
                                                           "type" => "identifier"
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
                                                            "remove_underscore" => 1,
                                                            "set_value" => "name",
                                                            "type" => "identifier"
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
                                                             "set_true" => "value_true",
                                                             "type" => "true"
                                                           }
                                                         ],
                                                         [
                                                           {
                                                             "set_true" => "value_false",
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
                                                           "remove_underscore" => 1,
                                                           "set_value" => "name",
                                                           "type" => "identifier"
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
                                                    "remove_underscore" => 1,
                                                    "set_value" => "name",
                                                    "type" => "identifier"
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
                                                         "set_true" => "value_null",
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
                                                           "set_value" => "value_string",
                                                           "type" => "string"
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
                                                     ]
                                                   ]
                                     },
                       "Definitions" => {
                                        "patterns" => [
                                                      [
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
                                                         "remove_underscore" => 1,
                                                         "set_value" => "name",
                                                         "type" => "identifier"
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
                                                               "remove_underscore" => 1,
                                                               "set_value" => "name",
                                                               "type" => "identifier"
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
                                                       "set_true" => "more",
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
                                                   "remove_underscore" => 1,
                                                   "set_value" => "name",
                                                   "type" => "identifier"
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
                                                            "append_value" => "value_strings",
                                                            "type" => "string"
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
                                                                  "append_value" => "value_strings",
                                                                  "type" => "string"
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
                                                        "remove_underscore" => 1,
                                                        "set_value" => "name",
                                                        "type" => "identifier"
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
                                                             "remove_underscore" => 1,
                                                             "set_value" => "name",
                                                             "type" => "identifier"
                                                           },
                                                           {
                                                             "type" => ";"
                                                           }
                                                         ]
                                                       ],
                                           "set" => [
                                                    "member_type",
                                                    "field"
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
                                                                "type" => "rule",
                                                                "value" => "ExtendedAttributeIdentList"
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
                                                                "value" => "ExtendedAttributeNameArgList"
                                                              }
                                                            ],
                                                            [
                                                              {
                                                                "type" => "rule",
                                                                "value" => "ExtendedAttributeNoArgs"
                                                              }
                                                            ]
                                                          ],
                                              "set_index" => 1
                                            },
                       "ExtendedAttributeArgList" => {
                                                     "patterns" => [
                                                                   [
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
                                                                     "next_is_not" => {
                                                                                      "(" => 1,
                                                                                      "=" => 1
                                                                                    },
                                                                     "set_value" => "value_name",
                                                                     "type" => "identifier"
                                                                   }
                                                                 ]
                                                               ]
                                                 },
                       "ExtendedAttributeIdentList" => {
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
                                                                         "value" => "IdentifierList"
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
                                                                            "set_value" => "value_name",
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
                                                                      "next_is_not" => {
                                                                                       "(" => 1,
                                                                                       "=" => 1
                                                                                     },
                                                                      "set_value" => "name1",
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
                                                           "set_true" => "value_n_infinity",
                                                           "type" => "-Infinity"
                                                         }
                                                       ],
                                                       [
                                                         {
                                                           "set_true" => "value_inifinity",
                                                           "type" => "Infinity"
                                                         }
                                                       ],
                                                       [
                                                         {
                                                           "set_true" => "value_nan",
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
                                                                  "set_value" => "super_name",
                                                                  "type" => "identifier"
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
                                                          "set_value" => "super_name",
                                                          "type" => "identifier"
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
                                                          "set_type" => "type",
                                                          "type" => "long"
                                                        },
                                                        {
                                                          "type" => "rule",
                                                          "value" => "OptionalLong"
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
                                                        "remove_underscore" => 1,
                                                        "set_value" => "name",
                                                        "type" => "identifier"
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
                                                           "set_true" => "iterator",
                                                           "type" => "iterator"
                                                         },
                                                         {
                                                           "type" => "rule",
                                                           "value" => "OperationIteratorInterfaceOrObject"
                                                         },
                                                         {
                                                           "type" => ";"
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
                                                         "type" => "sequence"
                                                       },
                                                       {
                                                         "type" => "<"
                                                       },
                                                       {
                                                         "set" => "type_suffix",
                                                         "type" => "rule",
                                                         "value" => "Type"
                                                       },
                                                       {
                                                         "type" => ">"
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
                                          "set" => [
                                                   "member_type",
                                                   "operation"
                                                 ]
                                        },
                       "OptionalIdentifier" => {
                                               "can_be_empty" => 1,
                                               "patterns" => [
                                                             [
                                                               {
                                                                 "remove_underscore" => 1,
                                                                 "set_value" => "name",
                                                                 "type" => "identifier"
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
                                                           "set_type" => "type2",
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
                                                                "remove_underscore" => 1,
                                                                "set_value" => "name",
                                                                "type" => "identifier"
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
                                                               "remove_underscore" => 1,
                                                               "set_value" => "name",
                                                               "type" => "identifier"
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
                                                    "patterns" => [
                                                                  [
                                                                    {
                                                                      "set_true" => "getter",
                                                                      "type" => "getter"
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
                                                         "set_true" => "serializer",
                                                         "type" => "serializer"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "SerializerRest"
                                                       }
                                                     ]
                                                   ]
                                     },
                       "SerializerRest" => {
                                           "can_be_empty" => 1,
                                           "patterns" => [
                                                         [
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
                                                         "set_true" => "type_any",
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
                                                              "type" => ";"
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
                                                         "type" => "["
                                                       },
                                                       {
                                                         "type" => "]"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "TypeSuffix"
                                                       }
                                                     ],
                                                     [
                                                       {
                                                         "set_true" => "type_null",
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
                                                      "remove_underscore" => 1,
                                                      "set_value" => "name",
                                                      "type" => "identifier"
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
                                                              "set_true" => "type_any",
                                                              "type" => "any"
                                                            },
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
                                                                    "set_true" => "unrestricted",
                                                                    "type" => "unrestricted"
                                                                  },
                                                                  {
                                                                    "type" => "rule",
                                                                    "value" => "FloatType"
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
                                                                  "set_true" => "unsigned",
                                                                  "type" => "unsigned"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "IntegerType"
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
                                              "set" => [
                                                       "member_type",
                                                       "dictionary_member"
                                                     ],
                                              "set_index" => 1
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
                                           }
                     },
          "keyword_tokens" => {
                              "ByteString" => {},
                              "DOMString" => {},
                              "Date" => {},
                              "Infinity" => {},
                              "NaN" => {},
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

