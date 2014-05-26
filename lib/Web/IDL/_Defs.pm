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
                                                                 "set_value" => "name",
                                                                 "type" => "identifier"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "Arguments" => {
                                          "can_be_empty" => 1,
                                          "patterns" => [
                                                          [
                                                            {
                                                              "type" => "other",
                                                              "value" => ","
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
                                                                  "set_value" => "member_type",
                                                                  "type" => "identifier",
                                                                  "value" => "attribute"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "Type"
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "Identifier"
                                                                },
                                                                {
                                                                  "type" => "other",
                                                                  "value" => ";"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "BooleanLiteral" => {
                                               "patterns" => [
                                                               [
                                                                 {
                                                                   "set_true" => "value_true",
                                                                   "type" => "identifier",
                                                                   "value" => "true"
                                                                 }
                                                               ],
                                                               [
                                                                 {
                                                                   "set_true" => "value_false",
                                                                   "type" => "identifier",
                                                                   "value" => "false"
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
                                                                 "set_value" => "name",
                                                                 "type" => "identifier"
                                                               },
                                                               {
                                                                 "type" => "other",
                                                                 "value" => "="
                                                               },
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "ReturnType"
                                                               },
                                                               {
                                                                 "type" => "other",
                                                                 "value" => "("
                                                               },
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "ArgumentList"
                                                               },
                                                               {
                                                                 "type" => "other",
                                                                 "value" => ")"
                                                               },
                                                               {
                                                                 "type" => "other",
                                                                 "value" => ";"
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
                                                          "set_value" => "member_type",
                                                          "type" => "identifier",
                                                          "value" => "const"
                                                        },
                                                        {
                                                          "type" => "rule",
                                                          "value" => "ConstType"
                                                        },
                                                        {
                                                          "set_value" => "name",
                                                          "type" => "identifier"
                                                        },
                                                        {
                                                          "type" => "other",
                                                          "value" => "="
                                                        },
                                                        {
                                                          "type" => "rule",
                                                          "value" => "ConstValue"
                                                        },
                                                        {
                                                          "type" => "other",
                                                          "value" => ";"
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
                                                               "type" => "identifier",
                                                               "value" => "null"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "Default" => {
                                        "can_be_empty" => 1,
                                        "patterns" => [
                                                        [
                                                          {
                                                            "type" => "other",
                                                            "value" => "="
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
                                                                 "set" => "value_string",
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
                                                               "set_value" => "definition_type",
                                                               "type" => "identifier",
                                                               "value" => "dictionary"
                                                             },
                                                             {
                                                               "set_value" => "name",
                                                               "type" => "identifier"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Inheritance"
                                                             },
                                                             {
                                                               "type" => "other",
                                                               "value" => "{"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "DictionaryMembers"
                                                             },
                                                             {
                                                               "type" => "other",
                                                               "value" => "}"
                                                             },
                                                             {
                                                               "type" => "other",
                                                               "value" => ";"
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
                                                                     "set_value" => "name",
                                                                     "type" => "identifier"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "Default"
                                                                   },
                                                                   {
                                                                     "type" => "other",
                                                                     "value" => ";"
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
                                                             "type" => "other",
                                                             "value" => "..."
                                                           }
                                                         ]
                                                       ]
                                       },
                         "Enum" => {
                                     "patterns" => [
                                                     [
                                                       {
                                                         "set_value" => "definition_type",
                                                         "type" => "identifier",
                                                         "value" => "enum"
                                                       },
                                                       {
                                                         "set_value" => "name",
                                                         "type" => "identifier"
                                                       },
                                                       {
                                                         "type" => "other",
                                                         "value" => "{"
                                                       },
                                                       {
                                                         "type" => "rule",
                                                         "value" => "EnumValueList"
                                                       },
                                                       {
                                                         "type" => "other",
                                                         "value" => "}"
                                                       },
                                                       {
                                                         "type" => "other",
                                                         "value" => ";"
                                                       }
                                                     ]
                                                   ]
                                   },
                         "EnumValueList" => {
                                              "patterns" => [
                                                              [
                                                                {
                                                                  "append_value" => "string_values",
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
                                                                       "type" => "other",
                                                                       "value" => ","
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
                                                                        "append_value" => "string_values",
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
                                                              "set_value" => "definition_type",
                                                              "type" => "identifier",
                                                              "value" => "exception"
                                                            },
                                                            {
                                                              "set_value" => "name",
                                                              "type" => "identifier"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "Inheritance"
                                                            },
                                                            {
                                                              "type" => "other",
                                                              "value" => "{"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "ExceptionMembers"
                                                            },
                                                            {
                                                              "type" => "other",
                                                              "value" => "}"
                                                            },
                                                            {
                                                              "type" => "other",
                                                              "value" => ";"
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
                                                                   "set_value" => "name",
                                                                   "type" => "identifier"
                                                                 },
                                                                 {
                                                                   "type" => "other",
                                                                   "value" => ";"
                                                                 }
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
                                                                             "type" => "other",
                                                                             "value" => "("
                                                                           },
                                                                           {
                                                                             "type" => "rule",
                                                                             "value" => "ArgumentList"
                                                                           },
                                                                           {
                                                                             "type" => "other",
                                                                             "value" => ")"
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
                                                                           "type" => "other",
                                                                           "value" => "="
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
                                                                               "type" => "other",
                                                                               "value" => "="
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
                                                                           "set_value" => "item_type",
                                                                           "type" => "other",
                                                                           "value" => "("
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         },
                                                                         {
                                                                           "type" => "other",
                                                                           "value" => ")"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "set_value" => "item_type",
                                                                           "type" => "other",
                                                                           "value" => "["
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         },
                                                                         {
                                                                           "type" => "other",
                                                                           "value" => "]"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         }
                                                                       ],
                                                                       [
                                                                         {
                                                                           "set_value" => "item_type",
                                                                           "type" => "other",
                                                                           "value" => "{"
                                                                         },
                                                                         {
                                                                           "type" => "rule",
                                                                           "value" => "ExtendedAttributeInner"
                                                                         },
                                                                         {
                                                                           "type" => "other",
                                                                           "value" => "}"
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
                                                                          "type" => "other",
                                                                          "value" => "["
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
                                                                          "type" => "other",
                                                                          "value" => "]"
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
                                                                                  "type" => "other",
                                                                                  "value" => "="
                                                                                },
                                                                                {
                                                                                  "set_value" => "value_name",
                                                                                  "type" => "identifier"
                                                                                },
                                                                                {
                                                                                  "type" => "other",
                                                                                  "value" => "("
                                                                                },
                                                                                {
                                                                                  "type" => "rule",
                                                                                  "value" => "ArgumentList"
                                                                                },
                                                                                {
                                                                                  "type" => "other",
                                                                                  "value" => ")"
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
                                                                              "type" => "other",
                                                                              "value" => "("
                                                                            },
                                                                            {
                                                                              "append" => "value_types",
                                                                              "type" => "rule",
                                                                              "value" => "Type"
                                                                            },
                                                                            {
                                                                              "type" => "other",
                                                                              "value" => ","
                                                                            },
                                                                            {
                                                                              "append" => "value_types",
                                                                              "type" => "rule",
                                                                              "value" => "Type"
                                                                            },
                                                                            {
                                                                              "type" => "other",
                                                                              "value" => ")"
                                                                            }
                                                                          ]
                                                                        ]
                                                        },
                         "ExtendedAttributes" => {
                                                   "can_be_empty" => 1,
                                                   "patterns" => [
                                                                   [
                                                                     {
                                                                       "type" => "other",
                                                                       "value" => ","
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
                                                                 "type" => "identifier",
                                                                 "value" => "-Infinity"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "set_true" => "value_inifinity",
                                                                 "type" => "identifier",
                                                                 "value" => "Infinity"
                                                               }
                                                             ],
                                                             [
                                                               {
                                                                 "set_true" => "value_nan",
                                                                 "type" => "identifier",
                                                                 "value" => "NaN"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "FloatType" => {
                                          "patterns" => [
                                                          [
                                                            {
                                                              "set_value" => "type",
                                                              "type" => "identifier",
                                                              "value" => "float"
                                                            }
                                                          ],
                                                          [
                                                            {
                                                              "set_value" => "type",
                                                              "type" => "identifier",
                                                              "value" => "double"
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
                                                                "type" => "other",
                                                                "value" => ","
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
                                                                        "set_value" => "definition_type",
                                                                        "type" => "identifier",
                                                                        "value" => "implements"
                                                                      },
                                                                      {
                                                                        "set_value" => "super_name",
                                                                        "type" => "identifier"
                                                                      },
                                                                      {
                                                                        "type" => "other",
                                                                        "value" => ";"
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
                                                            "type" => "identifier",
                                                            "value" => "inherit"
                                                          }
                                                        ]
                                                      ]
                                      },
                         "Inheritance" => {
                                            "can_be_empty" => 1,
                                            "patterns" => [
                                                            [
                                                              {
                                                                "type" => "other",
                                                                "value" => ":"
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
                                                                "set_value" => "type",
                                                                "type" => "identifier",
                                                                "value" => "short"
                                                              }
                                                            ],
                                                            [
                                                              {
                                                                "set_value" => "type",
                                                                "type" => "identifier",
                                                                "value" => "long"
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
                                                              "set_value" => "definition_type",
                                                              "type" => "identifier",
                                                              "value" => "interface"
                                                            },
                                                            {
                                                              "set_value" => "name",
                                                              "type" => "identifier"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "Inheritance"
                                                            },
                                                            {
                                                              "type" => "other",
                                                              "value" => "{"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "InterfaceMembers"
                                                            },
                                                            {
                                                              "type" => "other",
                                                              "value" => "}"
                                                            },
                                                            {
                                                              "type" => "other",
                                                              "value" => ";"
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
                                                                 "type" => "identifier",
                                                                 "value" => "iterator"
                                                               },
                                                               {
                                                                 "type" => "rule",
                                                                 "value" => "OperationIteratorInterfaceOrObject"
                                                               },
                                                               {
                                                                 "type" => "other",
                                                                 "value" => ";"
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
                                                               "set_value" => "type",
                                                               "type" => "identifier",
                                                               "value" => "ByteString"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "TypeSuffix"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_value" => "type",
                                                               "type" => "identifier",
                                                               "value" => "DOMString"
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
                                                               "type" => "identifier",
                                                               "value" => "sequence"
                                                             },
                                                             {
                                                               "type" => "other",
                                                               "value" => "<"
                                                             },
                                                             {
                                                               "set" => "type_suffix",
                                                               "type" => "rule",
                                                               "value" => "Type"
                                                             },
                                                             {
                                                               "type" => "other",
                                                               "value" => ">"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "Null"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_value" => "type",
                                                               "type" => "identifier",
                                                               "value" => "object"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "TypeSuffix"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_value" => "type",
                                                               "type" => "identifier",
                                                               "value" => "Date"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "TypeSuffix"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_value" => "type",
                                                               "type" => "identifier",
                                                               "value" => "RegExp"
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
                                                         "type" => "other",
                                                         "value" => "?"
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
                                                                                       "type" => "identifier",
                                                                                       "value" => "object"
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
                                                                  "type" => "other",
                                                                  "value" => "("
                                                                },
                                                                {
                                                                  "type" => "rule",
                                                                  "value" => "ArgumentList"
                                                                },
                                                                {
                                                                  "type" => "other",
                                                                  "value" => ")"
                                                                },
                                                                {
                                                                  "type" => "other",
                                                                  "value" => ";"
                                                                }
                                                              ]
                                                            ]
                                            },
                         "OptionalIdentifier" => {
                                                   "can_be_empty" => 1,
                                                   "patterns" => [
                                                                   [
                                                                     {
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
                                                                              "type" => "other",
                                                                              "value" => "="
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
                                                                 "set_value" => "type2",
                                                                 "type" => "identifier",
                                                                 "value" => "long"
                                                               }
                                                             ]
                                                           ]
                                           },
                         "OptionalOrRequiredArgument" => {
                                                           "patterns" => [
                                                                           [
                                                                             {
                                                                               "set_true" => "optional",
                                                                               "type" => "identifier",
                                                                               "value" => "optional"
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
                                                            "type" => "identifier",
                                                            "value" => "partial"
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
                                                                      "set_value" => "definition_type",
                                                                      "type" => "identifier",
                                                                      "value" => "dictionary"
                                                                    },
                                                                    {
                                                                      "set_value" => "name",
                                                                      "type" => "identifier"
                                                                    },
                                                                    {
                                                                      "type" => "other",
                                                                      "value" => "{"
                                                                    },
                                                                    {
                                                                      "type" => "rule",
                                                                      "value" => "DictionaryMembers"
                                                                    },
                                                                    {
                                                                      "type" => "other",
                                                                      "value" => "}"
                                                                    },
                                                                    {
                                                                      "type" => "other",
                                                                      "value" => ";"
                                                                    }
                                                                  ]
                                                                ]
                                                },
                         "PartialInterface" => {
                                                 "patterns" => [
                                                                 [
                                                                   {
                                                                     "set_value" => "definition_type",
                                                                     "type" => "identifier",
                                                                     "value" => "interface"
                                                                   },
                                                                   {
                                                                     "set_value" => "name",
                                                                     "type" => "identifier"
                                                                   },
                                                                   {
                                                                     "type" => "other",
                                                                     "value" => "{"
                                                                   },
                                                                   {
                                                                     "type" => "rule",
                                                                     "value" => "InterfaceMembers"
                                                                   },
                                                                   {
                                                                     "type" => "other",
                                                                     "value" => "}"
                                                                   },
                                                                   {
                                                                     "type" => "other",
                                                                     "value" => ";"
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
                                                                  "set_value" => "type",
                                                                  "type" => "identifier",
                                                                  "value" => "boolean"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_value" => "type",
                                                                  "type" => "identifier",
                                                                  "value" => "byte"
                                                                }
                                                              ],
                                                              [
                                                                {
                                                                  "set_value" => "type",
                                                                  "type" => "identifier",
                                                                  "value" => "octet"
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
                                                             "type" => "identifier",
                                                             "value" => "readonly"
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
                                                               "set_value" => "type",
                                                               "type" => "identifier",
                                                               "value" => "void"
                                                             }
                                                           ]
                                                         ]
                                         },
                         "SerializationPattern" => {
                                                     "patterns" => [
                                                                     [
                                                                       {
                                                                         "type" => "other",
                                                                         "value" => "{"
                                                                       },
                                                                       {
                                                                         "set" => "value_map",
                                                                         "type" => "rule",
                                                                         "value" => "SerializationPatternMap"
                                                                       },
                                                                       {
                                                                         "type" => "other",
                                                                         "value" => "}"
                                                                       }
                                                                     ],
                                                                     [
                                                                       {
                                                                         "type" => "other",
                                                                         "value" => "["
                                                                       },
                                                                       {
                                                                         "set" => "value_list",
                                                                         "type" => "rule",
                                                                         "value" => "SerializationPatternList"
                                                                       },
                                                                       {
                                                                         "type" => "other",
                                                                         "value" => "]"
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
                                                                             "type" => "identifier",
                                                                             "value" => "getter"
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
                                                                            "type" => "identifier",
                                                                            "value" => "getter"
                                                                          }
                                                                        ],
                                                                        [
                                                                          {
                                                                            "set_true" => "inherit",
                                                                            "type" => "identifier",
                                                                            "value" => "inherit"
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
                                                               "type" => "identifier",
                                                               "value" => "serializer"
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
                                                                   "type" => "other",
                                                                   "value" => "="
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
                                                               "type" => "identifier",
                                                               "value" => "any"
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
                                                            "type" => "identifier",
                                                            "value" => "getter"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "set_true" => "setter",
                                                            "type" => "identifier",
                                                            "value" => "setter"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "set_true" => "creator",
                                                            "type" => "identifier",
                                                            "value" => "creator"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "set_true" => "deleter",
                                                            "type" => "identifier",
                                                            "value" => "deleter"
                                                          }
                                                        ],
                                                        [
                                                          {
                                                            "set_true" => "legacycaller",
                                                            "type" => "identifier",
                                                            "value" => "legacycaller"
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
                                                                 "type" => "identifier",
                                                                 "value" => "static"
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
                                                                "type" => "identifier",
                                                                "value" => "stringifier"
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
                                                                    "type" => "other",
                                                                    "value" => ";"
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
                                                               "type" => "other",
                                                               "value" => "["
                                                             },
                                                             {
                                                               "type" => "other",
                                                               "value" => "]"
                                                             },
                                                             {
                                                               "type" => "rule",
                                                               "value" => "TypeSuffix"
                                                             }
                                                           ],
                                                           [
                                                             {
                                                               "set_true" => "type_null",
                                                               "type" => "other",
                                                               "value" => "?"
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
                                                                                "type" => "other",
                                                                                "value" => "["
                                                                              },
                                                                              {
                                                                                "type" => "other",
                                                                                "value" => "]"
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
                                                            "set_value" => "definition_type",
                                                            "type" => "identifier",
                                                            "value" => "typedef"
                                                          },
                                                          {
                                                            "type" => "rule",
                                                            "value" => "Type"
                                                          },
                                                          {
                                                            "set_value" => "name",
                                                            "type" => "identifier"
                                                          },
                                                          {
                                                            "type" => "other",
                                                            "value" => ";"
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
                                                                    "type" => "identifier",
                                                                    "value" => "any"
                                                                  },
                                                                  {
                                                                    "type" => "other",
                                                                    "value" => "["
                                                                  },
                                                                  {
                                                                    "type" => "other",
                                                                    "value" => "]"
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
                                                                     "type" => "identifier",
                                                                     "value" => "or"
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
                                                              "type" => "other",
                                                              "value" => "("
                                                            },
                                                            {
                                                              "append" => "type_union",
                                                              "type" => "rule",
                                                              "value" => "UnionMemberType"
                                                            },
                                                            {
                                                              "type" => "identifier",
                                                              "value" => "or"
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
                                                              "type" => "other",
                                                              "value" => ")"
                                                            }
                                                          ]
                                                        ]
                                        },
                         "UnrestrictedFloatType" => {
                                                      "patterns" => [
                                                                      [
                                                                        {
                                                                          "set_true" => "unrestricted",
                                                                          "type" => "identifier",
                                                                          "value" => "unrestricted"
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
                                                                        "type" => "identifier",
                                                                        "value" => "unsigned"
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
                                                              "set_true" => "callback",
                                                              "type" => "identifier",
                                                              "value" => "callback"
                                                            },
                                                            {
                                                              "type" => "rule",
                                                              "value" => "CallbackRestOrInterface"
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
                       }
        };

