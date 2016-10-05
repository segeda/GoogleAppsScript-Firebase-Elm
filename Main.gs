function main() {
  const url = "http://pocasi.barak.cz/xmlout.php"; //Thanks!
  
  fetch(url);
}

function fetch(url) {
  try {
    var textContent = UrlFetchApp.fetch(url).getContentText();
    var xmlDocument = XmlService.parse(textContent);
    var pocasi = xmlDocument.getRootElement();
    
    insertIntoFusionTable(pocasi);
    pushIntoFirebase(pocasi);
  } catch(e) {}
}

function insertIntoFusionTable(pocasi) {
  try {
    var format = "INSERT INTO <FUSION-TABLE-ID> (Den, Cas, Teplota, Tlak, Vlhkost, RosBod) VALUES ('%s', '%s', %f, %d, %f, %f)";
    var sql = Utilities.formatString(format, pocasi.getChildText("den"), pocasi.getChildText("cas"), pocasi.getChildText("teplota"), pocasi.getChildText("tlak"), pocasi.getChildText("vlhkost"), pocasi.getChildText("rosbod"));
    FusionTables.Query.sql(sql);
  } catch (e) {}
}

function pushIntoFirebase(pocasi) {
  try {
    var database = FirebaseApp.getDatabaseByUrl("https://<FIREBASE-URL>.firebaseio.com/");
    var data = {
      den : pocasi.getChildText("den")
      , cas : pocasi.getChildText("cas")
      , teplota : parseFloat(pocasi.getChildText("teplota"))
      , tlak : parseInt(pocasi.getChildText("tlak"))
      , vlhkost : parseFloat(pocasi.getChildText("vlhkost"))
      , rosbod : parseFloat(pocasi.getChildText("rosbod"))
    };
    database.pushData("pocasi", data);
  } catch (e) {}
}
