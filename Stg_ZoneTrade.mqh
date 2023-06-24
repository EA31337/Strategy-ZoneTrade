/**
 * @file
 * Implements Indicator strategy to run common or custom indicators.
 */

// User input params.
INPUT_GROUP("ZoneTrade strategy: strategy params");
INPUT float ZoneTrade_LotSize = 0;                // Lot size
INPUT int ZoneTrade_SignalOpenMethod = 68;        // Signal open method
INPUT float ZoneTrade_SignalOpenLevel = 20;       // Signal open level
INPUT int ZoneTrade_SignalOpenFilterMethod = 32;  // Signal open filter method
INPUT int ZoneTrade_SignalOpenFilterTime = 3;     // Signal open filter time (0-31)
INPUT int ZoneTrade_SignalOpenBoostMethod = 0;    // Signal open boost method
INPUT int ZoneTrade_SignalCloseMethod = 0;        // Signal close method
INPUT int ZoneTrade_SignalCloseFilter = 32;       // Signal close filter (-127-127)
INPUT float ZoneTrade_SignalCloseLevel = 20;      // Signal close level
INPUT int ZoneTrade_PriceStopMethod = 0;          // Price limit method
INPUT float ZoneTrade_PriceStopLevel = 2;         // Price limit level
INPUT int ZoneTrade_TickFilterMethod = 32;        // Tick filter method (0-255)
INPUT float ZoneTrade_MaxSpread = 4.0;            // Max spread to trade (in pips)
INPUT short ZoneTrade_Shift = 0;                  // Shift
INPUT float ZoneTrade_OrderCloseLoss = 80;        // Order close loss
INPUT float ZoneTrade_OrderCloseProfit = 80;      // Order close profit
INPUT int ZoneTrade_OrderCloseTime = -30;         // Order close time in mins (>0) or bars (<0)
INPUT_GROUP("ZoneTrade strategy: Indicators params");
INPUT ENUM_INDICATOR_TYPE ZoneTrade_Indicator_Type1 = INDI_PIVOT;             // 1st indicator type to use
INPUT ENUM_INDICATOR_TYPE ZoneTrade_Indicator_Type2 = INDI_VROC;              // 2nd indicator type to use
INPUT int ZoneTrade_Indicator_Mode1 = 0;                                      // Mode to use for 1st indicator
INPUT int ZoneTrade_Indicator_Mode2 = 0;                                      // Mode to use for 2nd indicator
INPUT int ZoneTrade_Indicator_Shift1 = 0;                                     // Shift to use for 1st indicator
INPUT int ZoneTrade_Indicator_Shift2 = 0;                                     // Shift to use for 2nd indicator
INPUT string ZoneTrade_Indicator_Path = INDI_CUSTOM_PATH;                     // Custom only: Path
INPUT int ZoneTrade_Indicator_Shift = 0;                                      // Shift
INPUT ENUM_IDATA_SOURCE_TYPE ZoneTrade_Indicator_SourceType = IDATA_BUILTIN;  // Source type

// Structs.

// Defines struct with default user strategy values.
struct Stg_ZoneTrade_Params_Defaults : StgParams {
  Stg_ZoneTrade_Params_Defaults()
      : StgParams(::ZoneTrade_SignalOpenMethod, ::ZoneTrade_SignalOpenFilterMethod, ::ZoneTrade_SignalOpenLevel,
                  ::ZoneTrade_SignalOpenBoostMethod, ::ZoneTrade_SignalCloseMethod, ::ZoneTrade_SignalCloseFilter,
                  ::ZoneTrade_SignalCloseLevel, ::ZoneTrade_PriceStopMethod, ::ZoneTrade_PriceStopLevel,
                  ::ZoneTrade_TickFilterMethod, ::ZoneTrade_MaxSpread, ::ZoneTrade_Shift) {
    Set(STRAT_PARAM_LS, ZoneTrade_LotSize);
    Set(STRAT_PARAM_OCL, ZoneTrade_OrderCloseLoss);
    Set(STRAT_PARAM_OCP, ZoneTrade_OrderCloseProfit);
    Set(STRAT_PARAM_OCT, ZoneTrade_OrderCloseTime);
    Set(STRAT_PARAM_SOFT, ZoneTrade_SignalOpenFilterTime);
  }
};

class Stg_ZoneTrade : public Strategy {
 protected:
  IndicatorBase *GetIndicatorInstance(ENUM_INDICATOR_TYPE _type, ENUM_TIMEFRAMES _tf = NULL) {
    IndicatorBase *_indi = NULL;
    switch (_type) {
      case INDI_NONE:  // (None)
        break;
      case INDI_AC:  // Accelerator Oscillator
        _indi = new Indi_AC(_tf);
        break;
      case INDI_AD:  // Accumulation/Distribution
        _indi = new Indi_AD(_tf);
        break;
      case INDI_ADX:  // Average Directional Index
        _indi = new Indi_ADX(_tf);
        break;
      case INDI_ADXW:  // ADX by Welles Wilder
        _indi = new Indi_ADXW(_tf);
        break;
      case INDI_ALLIGATOR:  // Alligator
        _indi = new Indi_Alligator(_tf);
        break;
      case INDI_AMA:  // Adaptive Moving Average
        _indi = new Indi_AMA(_tf);
        break;
      case INDI_APPLIED_PRICE:  // Applied Price over OHLC Indicator
        _indi = new Indi_AppliedPrice(_tf);
        break;
      case INDI_AO:  // Awesome Oscillator
        _indi = new Indi_AO(_tf);
        break;
      case INDI_ASI:  // Accumulation Swing Index
        _indi = new Indi_ASI(_tf);
        break;
      case INDI_ATR:  // Average True Range
        _indi = new Indi_ATR(_tf);
        break;
      case INDI_BANDS:  // Bollinger Bands
        _indi = new Indi_Bands(_tf);
        break;
      case INDI_BANDS_ON_PRICE:  // Bollinger Bands (on Price)
        // @todo
        _indi = new Indi_Bands(_tf);
        break;
      case INDI_BEARS:  // Bears Power
        _indi = new Indi_BearsPower(_tf);
        break;
      case INDI_BULLS:  // Bulls Power
        _indi = new Indi_BullsPower(_tf);
        break;
      case INDI_BWMFI:  // Market Facilitation Index
        _indi = new Indi_BWMFI(_tf);
        break;
      case INDI_BWZT:  // Bill Williams' Zone Trade
        _indi = new Indi_BWZT(_tf);
        break;
      case INDI_CANDLE:  // Candle Pattern Detector
        _indi = new Indi_Candle(_tf);
        break;
      case INDI_CCI:  // Commodity Channel Index
        _indi = new Indi_CCI(_tf);
        break;
      case INDI_CCI_ON_PRICE:  // Commodity Channel Index (CCI) (on Price)
        // @todo
        _indi = new Indi_CCI(_tf);
        break;
      case INDI_CHAIKIN:  // Chaikin Oscillator
        _indi = new Indi_CHO(_tf);
        break;
      case INDI_CHAIKIN_V:  // Chaikin Volatility
        _indi = new Indi_CHV(_tf);
        break;
      case INDI_COLOR_BARS:  // Color Bars
        _indi = new Indi_ColorBars(_tf);
        break;
      case INDI_COLOR_CANDLES_DAILY:  // Color Candles Daily
        _indi = new Indi_ColorCandlesDaily(_tf);
        break;
      case INDI_COLOR_LINE:  // Color Line
        _indi = new Indi_ColorLine(_tf);
        break;
      case INDI_CUSTOM:  // Custom indicator
        _indi = new Indi_Custom(_tf);
        break;
      case INDI_CUSTOM_MOVING_AVG:  // Custom Moving Average
        _indi = new Indi_CustomMovingAverage(_tf);
        break;
      case INDI_DEMA:  // Double Exponential Moving Average
        _indi = new Indi_DEMA(_tf);
        break;
      case INDI_DEMARKER:  // DeMarker
        _indi = new Indi_DeMarker(_tf);
        break;
      case INDI_DEMO:  // Demo/Dummy Indicator
        _indi = new Indi_Demo(_tf);
        break;
      case INDI_DETRENDED_PRICE:  // Detrended Price Oscillator
        _indi = new Indi_Price(_tf);
        break;
      case INDI_DRAWER:  // Drawer (Socket-based) Indicator
        // @todo
        _indi = new Indi_Drawer(_tf);
        break;
      case INDI_ENVELOPES:  // Envelopes
        _indi = new Indi_Drawer(_tf);
        break;
      case INDI_ENVELOPES_ON_PRICE:  // Evelopes (on Price)
        // @todo
        _indi = new Indi_Envelopes(_tf);
        break;
      case INDI_FORCE:  // Force Index
        _indi = new Indi_Force(_tf);
        break;
      case INDI_FRACTALS:  // Fractals
        _indi = new Indi_Fractals(_tf);
        break;
      case INDI_FRAMA:  // Fractal Adaptive Moving Average
        _indi = new Indi_FrAMA(_tf);
        break;
      case INDI_GATOR:  // Gator Oscillator
        _indi = new Indi_Gator(_tf);
        break;
      case INDI_HEIKENASHI:  // Heiken Ashi
        _indi = new Indi_HeikenAshi(_tf);
        break;
      case INDI_ICHIMOKU:  // Ichimoku Kinko Hyo
        _indi = new Indi_Ichimoku(_tf);
        break;
      case INDI_KILLZONES:  // Killzones
        _indi = new Indi_Killzones(_tf);
        break;
      case INDI_MA:  // Moving Average
        _indi = new Indi_MA(_tf);
        break;
      case INDI_MACD:  // MACD
        _indi = new Indi_MACD(_tf);
        break;
      case INDI_MA_ON_PRICE:  // Moving Average (on Price).
        // @todo
        _indi = new Indi_MA(_tf);
        break;
      case INDI_MARKET_FI:  // Market Facilitation Index
        // @todo
        //_indi = new Indi_XXX(_tf);
        break;
      case INDI_MASS_INDEX:  // Mass Index
        _indi = new Indi_MassIndex(_tf);
        break;
      case INDI_MFI:  // Money Flow Index
        _indi = new Indi_MFI(_tf);
        break;
      case INDI_MOMENTUM:  // Momentum
        _indi = new Indi_Momentum(_tf);
        break;
      case INDI_MOMENTUM_ON_PRICE:  // Momentum (on Price)
        // @todo
        _indi = new Indi_Momentum(_tf);
        break;
      case INDI_OBV:  // On Balance Volume
        _indi = new Indi_OBV(_tf);
        break;
      case INDI_OHLC:  // OHLC (Open-High-Low-Close)
        _indi = new Indi_OHLC(_tf);
        break;
      case INDI_OSMA:  // OsMA
        _indi = new Indi_OsMA(_tf);
        break;
      case INDI_PATTERN:  // Pattern Detector
        _indi = new Indi_Pattern(_tf);
        break;
      case INDI_PIVOT:  // Pivot Detector
        _indi = new Indi_Pivot(_tf);
        break;
      case INDI_PRICE:  // Price
        _indi = new Indi_Price(_tf);
        break;
      case INDI_PRICE_CHANNEL:  // Price Channel
        _indi = new Indi_PriceChannel(_tf);
        break;
      case INDI_PRICE_FEEDER:  // Indicator which returns prices from custom array
        _indi = new Indi_PriceFeeder(_tf);
        break;
      case INDI_PRICE_VOLUME_TREND:  // Price and Volume Trend
        _indi = new Indi_PriceVolumeTrend(_tf);
        break;
      case INDI_RATE_OF_CHANGE:  // Rate of Change
        _indi = new Indi_RateOfChange(_tf);
        break;
      case INDI_RS:  // Indi_Math-based RSI indicator.
        _indi = new Indi_RS(_tf);
        break;
      case INDI_RSI:  // Relative Strength Index
        _indi = new Indi_RSI(_tf);
        break;
      case INDI_RSI_ON_PRICE:  // Relative Strength Index (RSI) (on Price)
        // @todo
        _indi = new Indi_RSI(_tf);
        break;
      case INDI_RVI:  // Relative Vigor Index
        _indi = new Indi_RVI(_tf);
        break;
      case INDI_SAR:  // Parabolic SAR
        _indi = new Indi_SAR(_tf);
        break;
      case INDI_SPECIAL_MATH:  // Math operations over given indicator.
        _indi = new Indi_Math(_tf);
        break;
      case INDI_STDDEV:  // Standard Deviation
        _indi = new Indi_StdDev(_tf);
        break;
      case INDI_STDDEV_ON_MA_SMA:  // Standard Deviation on Moving Average in SMA mode
        // @todo
        _indi = new Indi_StdDev(_tf);
        break;
      case INDI_STDDEV_ON_PRICE:  // Standard Deviation (on Price)
        // @todo
        _indi = new Indi_StdDev(_tf);
        break;
      case INDI_STDDEV_SMA_ON_PRICE:  // Standard Deviation in SMA mode (on Price)
        // @todo
        _indi = new Indi_StdDev(_tf);
        break;
      case INDI_STOCHASTIC:  // Stochastic Oscillator
        _indi = new Indi_Stochastic(_tf);
        break;
      case INDI_TEMA:  // Triple Exponential Moving Average
        _indi = new Indi_TEMA(_tf);
        break;
      case INDI_TICK:  // Tick
        // @todo
        //_indi = new Indi_Tick(_tf);
        break;
      case INDI_TMA_TRUE:  // Triangular Moving Average True
        // @todo
        //_indi = new Indi_TMA_True(_tf);
        break;
      case INDI_TRIX:  // Triple Exponential Moving Averages Oscillator
        _indi = new Indi_TRIX(_tf);
        break;
      case INDI_ULTIMATE_OSCILLATOR:  // Ultimate Oscillator
        _indi = new Indi_UltimateOscillator(_tf);
        break;
      case INDI_VIDYA:  // Variable Index Dynamic Average
        _indi = new Indi_VIDYA(_tf);
        break;
      case INDI_VOLUMES:  // Volumes
        _indi = new Indi_Volumes(_tf);
        break;
      case INDI_VROC:  // Volume Rate of Change
        _indi = new Indi_VROC(_tf);
        break;
      case INDI_WILLIAMS_AD:  // Larry Williams' Accumulation/Distribution
        _indi = new Indi_WilliamsAD(_tf);
        break;
      case INDI_WPR:  // Williams' Percent Range
        _indi = new Indi_WPR(_tf);
        break;
      case INDI_ZIGZAG:  // ZigZag
        _indi = new Indi_ZigZag(_tf);
        break;
      case INDI_ZIGZAG_COLOR:  // ZigZag Color
        _indi = new Indi_ZigZagColor(_tf);
        break;
      default:
        SetUserError(ERR_INVALID_PARAMETER);
        break;
    }
    return _indi;
  }

 public:
  Stg_ZoneTrade(StgParams &_sparams, TradeParams &_tparams, ChartParams &_cparams, string _name = "")
      : Strategy(_sparams, _tparams, _cparams, _name) {}

  static Stg_ZoneTrade *Init(ENUM_TIMEFRAMES _tf = NULL, EA *_ea = NULL) {
    // Initialize strategy initial values.
    Stg_ZoneTrade_Params_Defaults stg_indi_defaults;
    StgParams _stg_params(stg_indi_defaults);
    // Initialize Strategy instance.
    ChartParams _cparams(_tf, _Symbol);
    TradeParams _tparams;
    Strategy *_strat = new Stg_ZoneTrade(_stg_params, _tparams, _cparams, "ZoneTrade");
    return _strat;
  }

  /**
   * Event on strategy's init.
   */
  void OnInit() {
    int _ishift = ::ZoneTrade_Indicator_Shift;
    ENUM_TIMEFRAMES _tf = Get<ENUM_TIMEFRAMES>(STRAT_PARAM_TF);
    SetIndicator(GetIndicatorInstance(::ZoneTrade_Indicator_Type1, _tf), 0);
    SetIndicator(GetIndicatorInstance(::ZoneTrade_Indicator_Type2, _tf), 1);
  }

  /**
   * Check strategy's opening signal.
   */
  bool SignalOpen(ENUM_ORDER_TYPE _cmd, int _method, float _level = 0.0f, int _shift = 0) {
    IndicatorBase *_indi1 = GetIndicator(0);
    IndicatorBase *_indi2 = GetIndicator(1);
    // @todo: Fix loading indi's shift.
    int _ishift1 = ::ZoneTrade_Indicator_Shift1;
    int _ishift2 = ::ZoneTrade_Indicator_Shift2;
    bool _result = true;
    if (!_result) {
      // Returns false when indicator data is not valid.
      return false;
    }
    IndicatorSignal _signals1 = _indi1.GetSignals(4, _shift);
    switch (_cmd) {
      case ORDER_TYPE_BUY:
        // Buy signal.
        _result &= _indi1.IsIncreasing(1, ZoneTrade_Indicator_Mode1, _ishift1);
        _result &= _indi2.IsIncreasing(1, ZoneTrade_Indicator_Mode2, _ishift2);
        _result &= _indi1.IsIncByPct(_level, ZoneTrade_Indicator_Mode1, _ishift1, 1);
        _result &= _indi2.IsIncByPct(_level, ZoneTrade_Indicator_Mode2, _ishift2, 1);
        //_result &= _method > 0 ? _signals.CheckSignals(_method) : _signals.CheckSignalsAll(-_method);
        break;
      case ORDER_TYPE_SELL:
        // Sell signal.
        _result &= _indi1.IsDecreasing(1, ZoneTrade_Indicator_Mode1, _ishift1);
        _result &= _indi2.IsDecreasing(1, ZoneTrade_Indicator_Mode2, _ishift2);
        _result &= _indi1.IsDecByPct(_level, ZoneTrade_Indicator_Mode1, _ishift1, 1);
        _result &= _indi2.IsDecByPct(_level, ZoneTrade_Indicator_Mode2, _ishift2, 1);
        //_result &= _method > 0 ? _signals.CheckSignals(_method) : _signals.CheckSignalsAll(-_method);
        break;
    }
    return _result;
  }

  /**
   * Executes on new time periods.
   */
  void OnPeriod(unsigned int _periods = DATETIME_NONE) {
    if ((_periods & DATETIME_MINUTE) != 0) {
      // New minute started.
    }
    if ((_periods & DATETIME_HOUR) != 0) {
      // New hour started.
    }
    if ((_periods & DATETIME_DAY) != 0) {
      // New day started.
    }
    if ((_periods & DATETIME_WEEK) != 0) {
      // New week started.
    }
    if ((_periods & DATETIME_MONTH) != 0) {
      // New month started.
    }
    if ((_periods & DATETIME_YEAR) != 0) {
      // New year started.
    }
  }
};
