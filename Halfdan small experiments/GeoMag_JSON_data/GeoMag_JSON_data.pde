// https://imag-data.bgs.ac.uk/GIN_V1/WebServiceURLGenerator.jsp#capabilities_service

JSONObject json;

void setup() {

  json = loadJSONObject("https://imag-data.bgs.ac.uk:/GIN_V1/GINServices?Request=GetData&observatoryIagaCode=KNY&samplesPerDay=minute&dataStartDate=2025-02-28&dataDuration=1&publicationState=adjusted&orientation=native&format=json");
  println(json.getJSONArray("S"));
  //int id = json.getInt("id");
  //String species = json.getString("species");
  //String name = json.getString("name");

  //println(id + ", " + species + ", " + name);
}
