# note pour les conversion de données reçu. Map ou list ?

https://stackoverflow.com/questions/55430061/unhandled-exception-internallinkedhashmapstring-dynamic-is-not-a-subtype-of

Here are 2 common ways this could go wrong:

    If your response is a json array like

    [
        {
          key1: value1,
          key2: value2,
          key3: value3,
        },
        {
          key1: value1,
          key2: value2,
          key3: value3,
        },

        .....
    ] 

    Then, we use data[0]["name"], not data[0].name Unless we cast to an object that has the name property, we cannot use data[0].name

    We cast like this data = json.decode(response.body).cast<ObjectName>();

    ObjectName can be whatever object you want (Inbuilt or Custom). But make sure it has the name property

    If your response is a JSON object like

    {
        dataKey: [
          {
            key1: value1,
            key2: value2,
            key3: value3,
          } 
        ] 
    }

    Then json.decode will return a Map, not a List

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["dataKey"];
    print(data[0]["name"]);


    ---------------------------------------------------------------

    flutter: Caught error for velostan carto fetch : type 'Null' is not a subtype of type 'String' in type cast

    !

    type 'double' is not a subtype of type 'String'

    double.parse(val.toString());

