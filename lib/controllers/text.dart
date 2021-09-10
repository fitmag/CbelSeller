class TextController {
  static String price(int price) {
    String refactor = "";
    String data = price.toString();

    switch (data.length) {
      case 4:
        refactor = data[0] + " " + data[1] + data[2] + data[3] + " DA";
        break;
      case 5:
        refactor =
            data[0] + data[1] + " " + data[2] + data[3] + data[4] + " DA";
        break;
      case 6:
        refactor = data[0] +
            data[1] +
            data[2] +
            " " +
            data[3] +
            data[4] +
            data[5] +
            " DA";
        break;
      case 7:
        refactor = data[0] +
            " " +
            data[1] +
            data[2] +
            data[3] +
            " " +
            data[4] +
            data[5] +
            data[6] +
            " DA";
        break;
      case 8:
        refactor = data[0] +
            data[1] +
            " " +
            data[2] +
            data[3] +
            data[4] +
            " " +
            data[5] +
            data[6] +
            data[7] +
            " DA";
        break;
      default:
        refactor = data + " DA";
    }
    return refactor;
  }

  static List<String> getList(String images) => images.split(";");
}
