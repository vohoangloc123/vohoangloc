## Problem 2: Fancy Form

## Link website demo: https://currencyexchange102.netlify.app

### 1 Application Structure Description

### Purpose

The application helps users convert currencies between countries, automatically updates exchange rates, and validates inputs while displaying real-time exchange rates.

### Key Features

- **Enter Amount**: Supports valid number formatting, disallows negative numbers and non-numeric characters.
- **Select Currency Unit**: Users can choose currency units from a list (USD, VND, EUR, GBP, etc.).
- **Currency Conversion**: Calculates conversion results based on current exchange rates.
- **Swap Currencies**: Switch positions between "From Currency" ↔ "To Currency".
- **Display Results**: Shows the converted amount and the target currency unit.
- **Real-Time Exchange Rate Chart**: Displays exchange rates in a bar chart.

### Application Structure

#### Frontend (UI)

- **Language**: Flutter (Dart)
- **Libraries**:
  - `flutter_dotenv`: ^5.2.1 - Manages environment variables, stores API keys and configurations in a `.env` file.
  - `flutter_spinkit`: ^5.2.1 - Provides beautiful and easy-to-use loading spinners.
  - `http`: ^1.2.2 - Sends HTTP requests (GET, POST, PUT, DELETE, etc.) from Flutter to APIs or web services.
  - `google_fonts`: ^6.2.1 - Enables easy usage of Google Fonts in Flutter without manual font loading.

#### Main Screen

- Input the amount, select source and target currencies.
- Includes a "Convert" button and a "Swap" button to switch between the two currencies.
- Displays conversion results.

#### Exchange Rate Analysis Screen:

- Displays a real-time exchange rate chart.

#### Backend (Logic & API)

- **Features**:
  - Fetches exchange rates using a third-party API (ExchangeRateAPI).
  - Validates input data:
    - Amount must be greater than 0.
    - VND must be an integer.
    - Source and target currencies must be different.
  - Handles errors if the API fails to return results or encounters network issues.
  - Displays a real-time exchange rate chart.

#### Technologies:

- **Logic**: Calculation logic is implemented in Dart.
- **API Calls**: Managed via the `http` library.
- **Input Validation**:
  - Ensures valid and positive amounts.
  - Checks input currency format.
  - Validates that "From Currency" and "To Currency" are different.
  - Ensures "VND" is entered as an integer.

### Directory Structure

```plaintext
lib/
├── main.dart                                # Application entry point
├── screens/
    ├── currency_converter_screen.dart       # Main currency conversion screen
    ├── analysts_screen.dart                 # Exchange rate analysis screen
├── services/
    ├── currency_converter.dart              # API class for fetching exchange rates
    ├── fetch_exchange_rates.dart            # API class for fetching rates for the bar chart
├── widgets/
    ├── chart_painter.dart                   # Bar chart widget

```

### 2 Guide to Building and Running the Application

1 Installing Flutter:
Download and install the Flutter SDK from Flutter's official website.<br> Ensure that Android Studio or VS Code is installed, and the Flutter development environment is properly configured.<br>

2 Installing Dependencies: <br>

- Step 1: Open a terminal or command prompt and navigate to the project directory.<br>

- Step 2: Run the following command to install all required packages:
  `flutter pub get`<br>

- Step 3: Configure the API Key:

Visit https://www.exchangerate-api.com and create an account.<br>
After registering, the website will provide you with an API key.<br>
Create a .env file in the root/assets/ directory of the project.<br>
Open the .env file and add the following line to save the API key:
`API_KEY=your_api_key_here<br>`

- Step 4: Run the application on an emulator or a physical device:

Connect a physical device via USB or launch an emulator (Android Emulator/iOS Simulator).
Note: Ensure that Developer Mode is enabled on the physical device.<br>
Step 5: Run the application using the command:
flutter run<br>

Step 6: Build the application for release:

For Android: flutter build apk
For iOS: flutter build ios<br>
Step 7: Test the application:

Once the application is running, test key features such as currency conversion, data input, and result display.<br>

## Problem 3: Messy React

### 1 Issue: lhsPriority is not defined

-In useMemo, the variable lhsPriority is not declared.

-Fix: Replace lhsPriority with balancePriority (a declared variable).

```plaintext

if (balancePriority > -99) {}

```

### 2 Issue: blockchain has type any

-blockchain: any should be avoided as it removes the benefits of TypeScript.

-Fix: Use an enum for blockchain instead of a string.

```plaintext

enum Blockchain {
  Osmosis = "Osmosis",
  Ethereum = "Ethereum",
  Arbitrum = "Arbitrum",
  Zilliqa = "Zilliqa",
  Neo = "Neo",
}

```

### 3 Issue: Incorrect filter() logic

-The filtering condition is incorrect. filter() should keep valid items, but it currently removes all of them.

-Fix: Use a proper condition:

```plaintext

return balances.filter((balance: WalletBalance) => {
  return getPriority(balance.blockchain) > -99 && balance.amount > 0;
});

```

### 4 Issue: .sort() does not return a value in some cases

-Error: The sort() function does not return a value when leftPriority === rightPriority, causing issues.

-Fix: Add return 0 when leftPriority === rightPriority:

```plaintext

return balances.sort((lhs, rhs) => {
  const leftPriority = getPriority(lhs.blockchain);
  const rightPriority = getPriority(rhs.blockchain);
  if (leftPriority > rightPriority) return -1;
  if (leftPriority < rightPriority) return 1;
  return 0;
});

```

### 5 Issue: Unused formattedBalances

-Error: formattedBalances is created but never used.

-Fix: Integrate it directly into rows.

```plaintext

 formattedAmount={balance.amount.toFixed()}

```

### 6 Issue: Unnecessary dependency in useMemo()

-Problem: sortedBalances does not use prices, yet [balances, prices] is in the dependency array.

-Fix: Remove prices from the dependency array as it does not affect sortedBalances.

### 7 Issue: Avoid using key={index}

-Problem: Using key={index} is not recommended. If an \_id exists, use it instead.

-Fix: If currency is available, it can be used, but duplicate currencies in WalletBalance may cause React key conflicts. Use key={${balance.currency}-${balance.blockchain}} to ensure uniqueness.
