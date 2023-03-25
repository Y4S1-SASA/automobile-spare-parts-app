// ignore_for_file: constant_identifier_names
class Constants {
  //Icon constants
  static const EDIT_ICON = "assets/orders/icon-edit.png";
  static const DELETE_ICON = "assets/orders/icon-trash.png";
  static const LOCATION_ICON = "assets/orders/icon-location.png";
  static const CALENDAR_ICON = "assets/orders/icon-calendar.png";
  static const PAYPAL_ICON = "assets/orders/icon-paypal.png";
  static const MASTERCARD_ICON = "assets/orders/icon-mastercard.png";
  static const VISA_ICON = "assets/orders/icons-visa.png";
  static const CLOSE_CIRCLE_ICON = "assets/orders/icon-close-circle.png";
  static const SHEILD_TICK = "assets/orders/icon-shield-tick.png";
  static const NO_DATA_FOUND_ICON = "assets/orders/package.png";

  // Title Constants
  static const MY_ORDERS_TITLE = "My Orders";
  static const EDIT_ORDERS_TITLE = "Edit Order";
  static const DELETE_ORDER_TITLE = "Delete Order Confirmation";
  static const LOCATION_PICKER_TITLE = "Select Delivery Location";

  // Subtitle Constatnts
  static const DELETE_ORDER_CONFIRMATION =
      'Are you sure that you want to delete this order?';
  static const PAYMENT_VERIFIED =
      'Your payment has been verified! You can proceed to the My Reservations screen!';
  static const PAYMENT_FAILED =
      'Your payment has been failed! Please check payment details and try again or navigate back to home screen!';

  //Response Message Constants
  static const CREATE_ERROR = "Create Failed!";
  static const CREATE_SUCCESS = "Create Successful!";
  static const UPDATE_ERROR = "Update Failed!";
  static const UPDATE_SUCCESS = "Update Successful!";
  static const DELETE_ERROR = "Delete Failed!";
  static const DELETE_SUCCESS = "Delete Successful!";
  static const FAILED_TO_LOAD_DATA =
      "Error in accquiring the requested data via the API call";
  static const EMPTY_FIELDS_ERROR = "'Error Please fill all fields properly!'";
  static const NO_ORDERS = "No Previous Orders to Display";

  //Location Picker Constants
  static const API_KEY = "AIzaSyBTbf4elIdOrbCSicNAhA0A61sHjMd9aV4";
  static const BASE_URL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
}
