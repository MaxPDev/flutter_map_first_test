class OverpassQuery {

  String output;
  String timeout;
  String bbox;
  
  String elementType = "";
  String tagKey = "";
  String tagValue = "";
  String out = "";

  OverpassQuery({
    required this.output,
    required this.timeout,
    required this.bbox,
  });

  /**
   * Construit une requête avec [tagKey] et [tagValue],
   * de type Node et de sortie Out.
   */
  String buildBodyRequestNodeOut(String tagKey, String tagValue) {
    elementType = "node";
    out = "out";

    return '[out:$output][timeout:$timeout][bbox:$bbox];$elementType["$tagKey"="$tagValue"];$out;';
  }

}