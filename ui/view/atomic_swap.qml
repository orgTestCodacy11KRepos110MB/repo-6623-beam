import QtQuick 2.11
import QtQuick.Controls 1.2
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.3
import "controls"
import "utils.js" as Utils
import Beam.Wallet 1.0

Item {
    id: offersViewRoot
    Layout.fillWidth: true
    Layout.fillHeight: true

    SwapOffersViewModel {
        id: viewModel
    }

    ConfirmationDialog {
        id: betaDialog
        //% "Atomic Swap is in BETA"
        title: qsTrId("swap-beta-title")
        //% "I understand"
        okButtonText:        qsTrId("swap-alert-confirm-button")
        okButtonIconSource:  "qrc:/assets/icon-done.svg"
        cancelButtonVisible: false
        width: 470
        //% "Atomic Swap functionality is Beta at the moment. We recommend you not to send large amounts."
        text: qsTrId("swap-beta-message")
    }

    Component.onCompleted: {
        if (viewModel.showBetaWarning) {
            betaDialog.open()
        }
    }

    RowLayout {
        Title {
            //% "Atomic Swap"
            text: qsTrId("atomic-swap-title")
        }

        SvgImage {
            Layout.alignment: Qt.AlignLeft | Qt.AlignHCenter
            Layout.maximumHeight: 15
            Layout.maximumWidth: 42
            source: "qrc:/assets/beta-label.svg"
        }
    }

    StatusBar {
        id: status_bar
        model: statusbarModel
    }

    Component {
        id: offersViewComponent

        ColumnLayout {
            id: atomicSwapLayout
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            state: "offers"

            // callbacks for send views
            function onAccepted() {
                            offersStackView.pop();
                            atomicSwapLayout.state = "transactions";
                            transactionsTab.state = "filterInProgressTransactions";
            }
            function onClosed() {
                offersStackView.pop();
            }
            function onSwapToken(token) {
                offersStackView.pop();
                offersStackView.push(Qt.createComponent("send_swap.qml"),
                                    {"onAccepted": onAccepted,
                                        "onClosed": onClosed});
                offersStackView.currentItem.setToken(token);
            }
            function onAddress() {
                onlySwapTokenAlert.open();
            }
            ConfirmationDialog {
                id:                     onlySwapTokenAlert
                //% "Only swap token is allowed to use here."
                title:                  qsTrId("only-swap-token-allowed-allert-head")
                //% "You have provided a wallet address.\nPlease fill in swap token and try again."
                text:                   qsTrId("only-swap-token-allowed-allert-body")
                //% "I understand"
                okButtonText:           qsTrId("swap-alert-confirm-button")
                okButtonIconSource:     "qrc:/assets/icon-done.svg"
                cancelButtonVisible:    false
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight | Qt.AlignTop
                Layout.topMargin: 33
                spacing: 20

                CustomButton {
                    id: acceptOfferButton
                    Layout.minimumWidth: 172
                    Layout.preferredHeight: 32
                    Layout.maximumHeight: 32
                    palette.button: Style.accent_outgoing
                    palette.buttonText: Style.content_opposite
                    icon.source: "qrc:/assets/icon-accept-offer.svg"
                    //% "Accept offer"
                    text: qsTrId("atomic-swap-accept")
                    font.pixelSize: 12
                    //font.capitalization: Font.AllUppercase

                    onClicked: {
                        offersStackView.push(Qt.createComponent("send.qml"),
                                            {"isSwapMode": true,
                                             "onClosed": onClosed,
                                             "onSwapToken": onSwapToken,
                                             "onAddress": onAddress});
                    }
                }
                
                CustomButton {
                    id: sendOfferButton
                    Layout.minimumWidth: 172
                    Layout.preferredHeight: 32
                    Layout.maximumHeight: 32
                    palette.button: Style.accent_incoming
                    palette.buttonText: Style.content_opposite
                    icon.source: "qrc:/assets/icon-create-offer.svg"
                    //% "Create offer"
                    text: qsTrId("atomic-swap-create")
                    font.pixelSize: 12
                    //font.capitalization: Font.AllUppercase

                    onClicked: {
                        offersStackView.push(Qt.createComponent("receive_swap.qml"),
                                            {"modeSwitchEnabled": false,
                                             "onClosed": onClosed});
                        function onClosed() { offersStackView.pop(); }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                Layout.topMargin: 32
                spacing: 10

                SwapCurrencyAmountPane {
                    function activeTxCountStr() {
                        if (viewModel.activeTxCount == 1) {
                            //% "1 active transaction"
                            return qsTrId("atomic-swap-1active-tx-count")
                        }
                        return viewModel.activeTxCount
                            //% "%1 active transactions"
                            ? qsTrId("atomic-swap-active-tx-count")
                                .arg(viewModel.activeTxCount)
                            : "";
                    }
                    gradLeft: Style.swapCurrencyPaneGrLeftBEAM
                    currencyIcon: "qrc:/assets/icon-beam.svg"
                    valueStr: [Utils.formatAmount(viewModel.beamAvailable, false, true), Utils.symbolBeam].join(" ")
                    valueSecondaryStr: activeTxCountStr()
                    visible: true
                }

                function btcAmount() {
                    return viewModel.hasBtcTx ? "" : Utils.formatAmount(viewModel.btcAvailable, false, true) + " " + Utils.symbolBtc;
                }

                function ltcAmount() {
                    return viewModel.hasLtcTx ? "" : Utils.formatAmount(viewModel.ltcAvailable, false, true) + " " + Utils.symbolLtc;
                }

                function qtumAmount() {
                    return viewModel.hasQtumTx ? "" : Utils.formatAmount(viewModel.qtumAvailable, false, true) + " " + Utils.symbolQtum;
                }

                //% "Transaction is in progress"
                property string kTxInProgress: qsTrId("swap-beta-tx-in-progress")

                function btcActiveTxStr() {
                    return viewModel.hasBtcTx ? kTxInProgress : "";
                }

                function ltcActiveTxStr() {
                    return viewModel.hasLtcTx ? kTxInProgress : "";
                }

                function qtumActiveTxStr() {
                    return viewModel.hasQtumTx ? kTxInProgress : "";
                }

                SwapCurrencyAmountPane {
                    gradLeft: Style.swapCurrencyPaneGrLeftBTC
                    currencyIcon: "qrc:/assets/icon-btc.svg"
                    valueStr: parent.btcAmount()
                    valueSecondaryStr: parent.btcActiveTxStr()
                    showLoader: viewModel.btcOK && parent.btcActiveTxStr().length
                    isOk: viewModel.btcOK
                    isConnecting: viewModel.btcConnecting
                    visible: BeamGlobals.haveBtc()
                    //% "Connecting..."
                    textConnecting: qsTrId("swap-connecting")
                    //% "Cannot connect to peer. Please check in the address in settings and retry."
                    textConnectionError: qsTrId("swap-beta-connection-error")
                }

                SwapCurrencyAmountPane {
                    gradLeft: Style.swapCurrencyPaneGrLeftLTC
                    currencyIcon: "qrc:/assets/icon-ltc.svg"
                    valueStr: parent.ltcAmount()
                    valueSecondaryStr: parent.ltcActiveTxStr()
                    showLoader: viewModel.ltcOK && parent.ltcActiveTxStr().length
                    isOk: viewModel.ltcOK
                    isConnecting: viewModel.ltcConnecting
                    visible: BeamGlobals.haveLtc()
                    textConnecting: qsTrId("swap-connecting")
                    textConnectionError: qsTrId("swap-beta-connection-error")
                }

                SwapCurrencyAmountPane {
                    gradLeft: Style.swapCurrencyPaneGrLeftQTUM
                    currencyIcon: "qrc:/assets/icon-qtum.svg"
                    valueStr: parent.qtumAmount()
                    valueSecondaryStr: parent.qtumActiveTxStr()
                    showLoader: viewModel.qtumOK && parent.qtumActiveTxStr().length
                    isOk: viewModel.qtumOK
                    isConnecting: viewModel.qtumConnecting
                    visible: BeamGlobals.haveQtum()
                    textConnecting: qsTrId("swap-connecting")
                    textConnectionError: qsTrId("swap-beta-connection-error")
                }

                SwapCurrencyAmountPane {
                    id: swapOptions
                    gradLeft: Style.swapCurrencyPaneGrLeftOther
                    gradRight: Style.swapCurrencyPaneGrLeftOther
                    //% "Connect other currency wallet to start trading"
                    valueStr: qsTrId("atomic-swap-connect-other")
                    textSize: 14
                    rectOpacity: 1.0
                    textColor: Style.active
                    isOk: true
                    borderSize: 1
                    visible: !BeamGlobals.haveBtc() || !BeamGlobals.haveLtc() || !BeamGlobals.haveQtum()
                    MouseArea {
                        id:                clickArea
                        anchors.fill:      parent
                        acceptedButtons:   Qt.LeftButton
                        onClicked:         main.openSwapSettings()
                        hoverEnabled:      true
                        onPositionChanged: clickArea.cursorShape = Qt.PointingHandCursor;
                    }
                }
                Component.onCompleted: {
                    var currencyIcons = [];
                    if (!BeamGlobals.haveBtc())
                        currencyIcons.push("qrc:/assets/icon-btc.svg");
                    if (!BeamGlobals.haveLtc())
                        currencyIcons.push("qrc:/assets/icon-ltc.svg");
                    if (!BeamGlobals.haveQtum())
                        currencyIcons.push("qrc:/assets/icon-qtum.svg");

                    swapOptions.currencyIcons = currencyIcons;
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                Layout.topMargin: 50

                TxFilter {
                    id: offersTabSelector
                    Layout.alignment: Qt.AlignTop
                    //% "Active offers"
                    label: qsTrId("atomic-swap-active-offers-tab")
                    onClicked: atomicSwapLayout.state = "offers"
                    capitalization: Font.AllUppercase
                }

                TxFilter {
                    id: transactionsTabSelector
                    Layout.alignment: Qt.AlignTop
                    //% "Transactions"
                    label: qsTrId("atomic-swap-transactions-tab")
                    onClicked: {
                        atomicSwapLayout.state = "transactions";
                        transactionsTab.state = "filterAllTransactions"
                    }
                    capitalization: Font.AllUppercase
                }
            }
            
            states: [
                State {
                    name: "offers"
                    PropertyChanges { target: offersTabSelector; state: "active" }
                    PropertyChanges { target: activeOffersTab; visible: true }
                    PropertyChanges { target: transactionsTab; visible: false }
                },
                State {
                    name: "transactions"
                    PropertyChanges { target: transactionsTabSelector; state: "active" }
                    PropertyChanges { target: activeOffersTab; visible: false }
                    PropertyChanges { target: transactionsTab; visible: true }
                }
            ]
            
            Item {
                Layout.fillWidth:  true
                Layout.fillHeight: true

                ColumnLayout {
                    id: activeOffersTab
                    visible: false

                    anchors.fill: parent
                    anchors.topMargin: 20

                    RowLayout {
                        spacing: 0

                        SFText {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                            font.pixelSize: 14
                            color: Style.content_main
                            // opacity: 0.6
                            //% "Receive BEAM"
                            text: qsTrId("atomic-swap-receive-beam")
                        }

                        CustomSwitch {
                            id: sendReceiveBeamSwitch
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                            // opacity: 0.6
                        }

                        SFText {
                            Layout.alignment:  Qt.AlignHCenter | Qt.AlignLeft
                            Layout.leftMargin: 10
                            font.pixelSize: 14
                            color: Style.content_main
                            // opacity: 0.6
                            //% "Send BEAM"
                            text: qsTrId("atomic-swap-send-beam")
                        }

                        CustomCheckBox {
                            id: checkboxOnlyMyOffers
                            Layout.alignment:  Qt.AlignHCenter
                            Layout.leftMargin: 60
                            //% "Only my offers"
                            text:           qsTrId("atomic-swap-only-my-offers")
                        }

                        CustomCheckBox {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignLeft
                            Layout.leftMargin: 60
                            //% "Fit my current balance"
                            text: qsTrId("atomic-swap-fit-current-balance")
                            onClicked: {
                                console.log("todo: fit current balance checkbox pressed");
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        SFText {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignRight
                            Layout.rightMargin: 10
                            font.pixelSize: 14
                            color: Style.content_main
                            opacity: 0.5
                            //% "Currency"
                            text: qsTrId("atomic-swap-currency")
                        }
                    
                        CustomComboBox {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignRight
                            height: 32
                            Layout.minimumWidth: 70
                            Layout.maximumWidth: 80

                            fontPixelSize: 14
                            fontLetterSpacing: 0.47
                            color: Style.content_main

                            currentIndex: viewModel.getCoinType()
                            model: ["BTC", "LTC", "QTUM"]
                            onCurrentIndexChanged: viewModel.setCoinType(currentIndex)
                        }
                    }   // RowLayout

                    ColumnLayout {
                        Layout.minimumWidth: parent.width
                        Layout.minimumHeight: parent.height
                        visible: offersTable.model.count == 0

                        SvgImage {
                            Layout.topMargin: 100
                            Layout.alignment: Qt.AlignHCenter
                            source:     "qrc:/assets/atomic-empty-state.svg"
                            sourceSize: Qt.size(60, 60)
                        }

                        SFText {
                            Layout.topMargin:     30
                            Layout.alignment:     Qt.AlignHCenter
                            horizontalAlignment:  Text.AlignHCenter
                            font.pixelSize:       14
                            color:                Style.content_main
                            opacity:              0.5
                            lineHeight:           1.43
                            //% "There are no active offers at the moment.\nPlease try again later or create an offer yourself."
                            text:                 qsTrId("atomic-no-offers")
                        }

                        Item {
                            Layout.fillHeight: true
                        }
                    }

                    CustomTableView {
                        id: offersTable

                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth : true
                        Layout.fillHeight : true
                        Layout.topMargin: 14
                        visible: offersTable.model.count > 0

                        property int rowHeight: 56
                        property int columnWidth: (width - swapCoinsColumn.width) / 6

                        frameVisible: false
                        selectionMode: SelectionMode.NoSelection
                        backgroundVisible: false
                        sortIndicatorVisible: true
                        sortIndicatorColumn: 1
                        sortIndicatorOrder: Qt.DescendingOrder

                        onSortIndicatorColumnChanged: {
                            sortIndicatorOrder = sortIndicatorColumn == 1 || sortIndicatorColumn == 5
                                ? Qt.DescendingOrder
                                : Qt.AscendingOrder;
                        }

                        model: SortFilterProxyModel {
                            id: proxyModel
                            source: SortFilterProxyModel {
                                source: viewModel.allOffers
                                filterRole: "isBeamSide"
                                filterString: sendReceiveBeamSwitch.checked ? "false" : "true"
                                filterSyntax: SortFilterProxyModel.Wildcard
                                filterCaseSensitivity: Qt.CaseInsensitive
                            }

                            sortOrder: offersTable.sortIndicatorOrder
                            sortCaseSensitivity: Qt.CaseInsensitive
                            sortRole: offersTable.getColumn(offersTable.sortIndicatorColumn).role + "Sort"

                            filterRole: "isOwnOffer"
                            filterString: checkboxOnlyMyOffers.checked ? "true" : "*"
                            filterSyntax: SortFilterProxyModel.Wildcard
                            filterCaseSensitivity: Qt.CaseInsensitive
                        }

                        rowDelegate: Item {
                            height: offersTable.rowHeight
                            anchors.left: parent.left
                            anchors.right: parent.right

                            Rectangle {
                                anchors.fill: parent
                                color: styleData.selected ? Style.row_selected :
                                        (styleData.alternate ? Style.background_row_even : Style.background_row_odd)
                            }
                        }

                        itemDelegate: TableItem {
                            text: styleData.value
                            elide: Text.ElideRight
                        }

                        TableViewColumn {
                            id: swapCoinsColumn
                            role: "swapCoin"
                            width: 55
                            movable: false
                            resizable: false
                            elideMode: Text.ElideRight
                            delegate: Item {
                                id: coinLabels
                                width: parent.width
                                height: offersTable.rowHeight
                                property var swapCoin: styleData.value
                                property var isSendBeam: offersTable.model.get(styleData.row).isBeamSide
                                
                                anchors.fill: parent
                                anchors.leftMargin: 20
                                anchors.rightMargin: 20
                                anchors.topMargin: 18

                                RowLayout {
                                    layoutDirection: Qt.RightToLeft
                                    spacing: -4
                                    SvgImage {
                                        sourceSize: Qt.size(20, 20)
                                        source: isSendBeam ? "qrc:/assets/icon-beam.svg" : getCoinIcon(swapCoin)
                                    }
                                    SvgImage {
                                        sourceSize: Qt.size(20, 20)
                                        source: isSendBeam ? getCoinIcon(swapCoin) : "qrc:/assets/icon-beam.svg"
                                    }
                                }
                            }
                        }

                        TableViewColumn {
                            role: "timeCreated"
                            //% "Created on"
                            title: qsTrId("atomic-swap-time-created")
                            width: offersTable.columnWidth
                            movable: false
                            resizable: false
                        }

                        TableViewColumn {
                            role: "amountSend"
                            //% "Send"
                            title: qsTrId("atomic-swap-amount-send")
                            width: offersTable.columnWidth
                            movable: false
                            resizable: false
                            delegate: TableItem {
                                text: styleData.value
                                elide: Text.ElideRight
                                fontWeight: Font.Bold
                                fontStyleName: "Bold"
                                fontSizeMode: Text.Fit
                            }
                        }

                        TableViewColumn {
                            role: "amountReceive"
                            //% "Receive"
                            title: qsTrId("atomic-swap-amount-receive")
                            width: offersTable.columnWidth
                            movable: false
                            resizable: false
                            delegate: TableItem {
                                text: styleData.value
                                elide: Text.ElideRight
                                fontWeight: Font.Bold
                                fontStyleName: "Bold"
                                fontSizeMode: Text.Fit
                            }
                        }

                        TableViewColumn {
                            role: "rate"
                            //% "Rate"
                            title: qsTrId("atomic-swap-rate")
                            width: offersTable.columnWidth
                            movable: false
                            resizable: false
                            delegate: TableItem {
                                text: Utils.formatAmount(styleData.value, false, true)
                            }
                        }

                        TableViewColumn {
                            role: "expiration"
                            //% "Expiration"
                            title: qsTrId("atomic-swap-expiration")
                            width: offersTable.columnWidth
                            movable: false
                            resizable: false
                        }
                    
                        TableViewColumn {
                            id: offerActionsColumn
                            title: ""
                            width: offersTable.getAdjustedColumnWidth(offerActionsColumn)
                            movable: false
                            resizable: false
                            delegate: Component {
                                id: actions
                                Item {
                                    Layout.fillWidth : true
                                    Layout.fillHeight : true
                                    property var isOwnOffer: offersTable.model.get(styleData.row).isOwnOffer

                                    SFText {
                                        anchors.right: parent.right
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.rightMargin: 20

                                        font.pixelSize: 14
                                        color: isOwnOffer ? Style.content_main : Style.active
                                        opacity: isOwnOffer ? 0.5 : 1.0
                                        text: isOwnOffer
                                                        //% "Cancel offer"
                                                        ? qsTrId("atomic-swap-cancel")
                                                        //% "Accept offer"
                                                        : qsTrId("atomic-swap-accept")

                                        MouseArea {
                                            anchors.fill: parent
                                            acceptedButtons: Qt.LeftButton
                                            onClicked: {
                                                if (isOwnOffer) {
                                                    var txID = offersTable.model.get(styleData.row).rawTxID
                                                    viewModel.cancelTx(txID);
                                                }
                                                else {
                                                    var txParameters = offersTable.model.get(styleData.row).rawTxParameters;
                                                    offersStackView.push(Qt.createComponent("send_swap.qml"),
                                                                        {"predefinedTxParams": txParameters,
                                                                         "onAccepted": onAccepted,
                                                                         "onClosed": onClosed});
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }   // CustomTableView : offersTable
                }   // ColumnLayout : activeOffersTab

                ColumnLayout {
                    id: transactionsTab
                    visible: false

                    anchors.fill: parent
                    anchors.topMargin: 14

                    state: "filterAllTransactions"

                    RowLayout {

                        TxFilter {
                            id: allTabSelector
                            //% "All"
                            label: qsTrId("atomic-swap-all-transactions-tab")
                            onClicked: transactionsTab.state = "filterAllTransactions"
                            capitalization: Font.AllUppercase
                        }

                        TxFilter {
                            id: inProgressTabSelector
                            //% "In progress"
                            label: qsTrId("atomic-swap-in-progress-transactions-tab")
                            onClicked: transactionsTab.state = "filterInProgressTransactions"
                            capitalization: Font.AllUppercase
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        CustomButton {
                            Layout.alignment: Qt.AlignRight
                            rightPadding: 5
                            textOpacity: 0
                            icon.source: "qrc:/assets/icon-delete.svg"
                            onClicked: console.log("todo: delete button pressed");
                        }
                    }

                    states: [
                        State {
                            name: "filterAllTransactions"
                            PropertyChanges { target: allTabSelector; state: "active" }
                            PropertyChanges { target: txProxyModel; filterString: "*" }
                        },
                        State {
                            name: "filterInProgressTransactions"
                            PropertyChanges { target: inProgressTabSelector; state: "active" }
                            PropertyChanges { target: txProxyModel; filterString: "true" }
                        }
                    ]

                    CustomTableView {
                        id: transactionsTable

                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.topMargin: 12

                        property int rowHeight: 56
                        property int columnWidth: (width - txSwapCoinsColumn.width - txSwapActionColumn.width) / 6

                        frameVisible: false
                        selectionMode: SelectionMode.NoSelection
                        backgroundVisible: false
                        sortIndicatorVisible: true
                        sortIndicatorColumn: 1
                        sortIndicatorOrder: Qt.DescendingOrder

                        onSortIndicatorColumnChanged: {
                            sortIndicatorOrder = sortIndicatorColumn == 1 
                                ? Qt.DescendingOrder
                                : Qt.AscendingOrder;
                        }

                        model: SortFilterProxyModel {
                            id: txProxyModel
                            source: viewModel.transactions

                            sortOrder: transactionsTable.sortIndicatorOrder
                            sortCaseSensitivity: Qt.CaseInsensitive
                            sortRole: transactionsTable.getColumn(transactionsTable.sortIndicatorColumn).role + "Sort"

                            filterRole: "isInProgress"
                            // filterString: "*"
                            filterSyntax: SortFilterProxyModel.Wildcard
                            filterCaseSensitivity: Qt.CaseInsensitive
                        }

                        rowDelegate: Item {
                            id: rowItem
                            height: ctransactionsTable.rowHeight
                            anchors.left: parent.left
                            anchors.right: parent.right
                            property bool collapsed: true

                            property var myModel: parent.model

                            onMyModelChanged: {
                                collapsed = true;
                                height = Qt.binding(function(){ return transactionsTable.rowHeight;});
                            }

                            Rectangle {
                                anchors.fill: parent                        
                                color: styleData.selected ? Style.row_selected :
                                        (styleData.alternate ? Style.background_row_even : Style.background_row_odd)
                            }

                            ColumnLayout {
                                id: rowColumn
                                width: parent.width
                                Rectangle {
                                    height: rowItem.height
                                    width: parent.width
                                    color: "transparent"
                                }
                                Item {
                                    id: txDetails
                                    height: 0
                                    width: parent.width
                                    clip: true

                                    property int maximumHeight: detailsPanel.implicitHeight

                                    Rectangle {
                                        anchors.fill: parent
                                        color: Style.background_details
                                    }
                                    SwapTransactionDetails {
                                        id: detailsPanel
                                        width: transactionsTable.width

                                        property var txRolesMap: myModel
                                        sendAddress:        txRolesMap && txRolesMap.addressTo ? txRolesMap.addressTo : ""
                                        receiveAddress:     txRolesMap && txRolesMap.addressFrom ? txRolesMap.addressFrom : ""
                                        fee:                txRolesMap && txRolesMap.fee ? txRolesMap.fee : ""
                                        comment:            txRolesMap && txRolesMap.comment ? txRolesMap.comment : ""
                                        txID:               txRolesMap && txRolesMap.txID ? txRolesMap.txID : ""
                                        kernelID:           txRolesMap && txRolesMap.kernelID ? txRolesMap.kernelID : ""
                                        status:             txRolesMap && txRolesMap.status ? txRolesMap.status : ""
                                        failureReason:      txRolesMap && txRolesMap.failureReason ? txRolesMap.failureReason : ""
                                        isIncome:           txRolesMap && txRolesMap.isIncome ? txRolesMap.isIncome : false
                                        hasPaymentProof:    txRolesMap && txRolesMap.hasPaymentProof ? txRolesMap.hasPaymentProof : false
                                        isSelfTx:           txRolesMap && txRolesMap.isSelfTransaction ? txRolesMap.isSelfTransaction : false
                                        rawTxID:            txRolesMap && txRolesMap.rawTxID ? txRolesMap.rawTxID : null
                                        
                                        onOpenExternal : function() {
                                            var url = Style.explorerUrl + "block?kernel_id=" + detailsPanel.kernelID;
                                            Utils.openExternal(url, viewModel, externalLinkConfirmation);
                                        } 
                                        onTextCopied: function (text) {
                                            BeamGlobals.copyToClipboard(text);
                                        }
                                        onCopyPaymentProof: function() {
                                            if (detailsPanel.rawTxID)
                                            {
                                                var paymentInfo = viewModel.getPaymentInfo(detailsPanel.rawTxID);
                                                if (paymentInfo.paymentProof.length == 0)
                                                {
                                                    paymentInfo.paymentProofChanged.connect(function() {
                                                        textCopied(paymentInfo.paymentProof);
                                                    });
                                                }
                                                else
                                                {
                                                    textCopied(paymentInfo.paymentProof);
                                                }
                                            }
                                        }
                                        onShowPaymentProof: {
                                            if (detailsPanel.rawTxID)
                                            {
                                                paymentInfoDialog.model = viewModel.getPaymentInfo(detailsPanel.rawTxID);
                                                paymentInfoDialog.open();
                                            }
                                        }
                                    }
                                }
                            }

                            MouseArea {
                                anchors.top: parent.top
                                anchors.left: parent.left
                                height: transactionsTable.rowHeight
                                width: parent.width

                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                onClicked: {
                                    if (styleData.row === undefined 
                                    || styleData.row < 0
                                    || styleData.row >= txProxyModel.count)
                                    {
                                        return;
                                    }
                                    if (mouse.button === Qt.RightButton )
                                    {
                                        transactionsTable.showContextMenu(styleData.row);
                                    }
                                    else if (mouse.button === Qt.LeftButton)
                                    {
                                        if (parent.collapsed)
                                        {
                                            expand.start()
                                        }
                                        else 
                                        {
                                            collapse.start()
                                        }
                                        parent.collapsed = !parent.collapsed;
                                    }
                                }
                            }

                            ParallelAnimation {
                                id: expand
                                running: false

                                property int expandDuration: 200

                                NumberAnimation {
                                    target: rowItem
                                    easing.type: Easing.Linear
                                    property: "height"
                                    to: transactionsTable.rowHeight + txDetails.maximumHeight
                                    duration: expand.expandDuration
                                }

                                NumberAnimation {
                                    target: txDetails
                                    easing.type: Easing.Linear
                                    property: "height"
                                    to: txDetails.maximumHeight
                                    duration: expand.expandDuration
                                }
                            }

                            ParallelAnimation {
                                id: collapse
                                running: false

                                property int collapseDuration: 200

                                NumberAnimation {
                                    target: rowItem
                                    easing.type: Easing.Linear
                                    property: "height"
                                    to: transactionsTable.rowHeight
                                    duration: collapse.collapseDuration
                                }

                                NumberAnimation {
                                    target: txDetails
                                    easing.type: Easing.Linear
                                    property: "height"
                                    to: 0
                                    duration: collapse.collapseDuration
                                }
                            }
                        }

                        itemDelegate: Item {
                            Item {
                                width: parent.width
                                height: transactionsTable.rowHeight

                                TableItem {
                                    text: styleData.value
                                    elide: styleData.elideMode
                                }
                            }
                        }

                        TableViewColumn {
                            id: txSwapCoinsColumn
                            role: "swapCoin"
                            width: 55
                            movable: false
                            resizable: false
                            elideMode: Text.ElideRight
                            delegate: Item {
                                id: coinLabels
                                width: parent.width
                                height: transactionsTable.rowHeight
                                property var swapCoin: styleData.value
                                property var isSendBeam: transactionsTable.model.get(styleData.row).isBeamSideSwap
                                
                                anchors.fill: parent
                                anchors.leftMargin: 20
                                anchors.rightMargin: 20
                                anchors.topMargin: 18

                                RowLayout {
                                    layoutDirection: Qt.RightToLeft
                                    spacing: -4
                                    SvgImage {
                                        sourceSize: Qt.size(20, 20)
                                        source: isSendBeam ? getCoinIcon(swapCoin) : "qrc:/assets/icon-beam.svg"
                                    }
                                    SvgImage {
                                        sourceSize: Qt.size(20, 20)
                                        source: isSendBeam ? "qrc:/assets/icon-beam.svg" : getCoinIcon(swapCoin)
                                    }
                                }
                            }
                        }

                        TableViewColumn {
                            role: "timeCreated"
                            //% "Created on"
                            title: qsTrId("atomic-swap-tx-table-created")
                            elideMode: Text.ElideRight
                            width: transactionsTable.columnWidth
                            movable: false
                            resizable: false
                        }
                        TableViewColumn {
                            role: "addressFrom"
                            //% "From"
                            title: qsTrId("atomic-swap-tx-table-from")
                            elideMode: Text.ElideMiddle
                            width: transactionsTable.columnWidth
                            movable: false
                            resizable: false
                        }
                        TableViewColumn {
                            role: "addressTo"
                            //% "To"
                            title: qsTrId("atomic-swap-tx-table-to")
                            elideMode: Text.ElideMiddle
                            width: transactionsTable.columnWidth
                            movable: false
                            resizable: false
                        }
                        TableViewColumn {
                            role: "amountSend"
                            //% "Sent"
                            title: qsTrId("atomic-swap-tx-table-sent")
                            elideMode: Text.ElideRight
                            width: transactionsTable.columnWidth
                            movable: false
                            resizable: false
                            delegate: Item {
                                Item {
                                    width: parent.width
                                    height: transactionsTable.rowHeight
                                    TableItem {
                                        text: (styleData.value === '' ? '' : '-') + styleData.value
                                        fontWeight: Font.Bold
                                        fontStyleName: "Bold"
                                        fontSizeMode: Text.Fit
                                        color: Style.accent_outgoing
                                        onCopyText: BeamGlobals.copyToClipboard(Utils.getAmountWithoutCurrency(styleData.value)) 
                                    }
                                }
                            }
                        }
                        TableViewColumn {
                            role: "amountReceive"
                            //% "Received"
                            title: qsTrId("atomic-swap-tx-table-received")
                            elideMode: Text.ElideRight
                            width: transactionsTable.columnWidth
                            movable: false
                            resizable: false
                            delegate: Item {
                                Item {
                                    width: parent.width
                                    height: transactionsTable.rowHeight
                                    TableItem {
                                        text: (styleData.value === '' ? '' : '+') + styleData.value
                                        fontWeight: Font.Bold
                                        fontStyleName: "Bold"
                                        fontSizeMode: Text.Fit
                                        color: Style.accent_incoming
                                        onCopyText: BeamGlobals.copyToClipboard(Utils.getAmountWithoutCurrency(styleData.value)) 
                                    }
                                }
                            }
                        }
                        TableViewColumn {
                            id: txStatusColumn
                            role: "status"
                            //% "Status"
                            title: qsTrId("atomic-swap-tx-table-status")
                            width: transactionsTable.getAdjustedColumnWidth(txStatusColumn)
                            movable: false
                            resizable: false
                            delegate: Item {
                                Item {
                                    width: parent.width
                                    height: transactionsTable.rowHeight

                                    RowLayout {
                                        Layout.alignment: Qt.AlignLeft
                                        anchors.fill: parent
                                        anchors.leftMargin: 10
                                        spacing: 10

                                        SvgImage {
                                            id: statusIcon
                                            Layout.alignment: Qt.AlignLeft

                                            sourceSize: Qt.size(20, 20)
                                            source: getIconSource()
                                            function getIconSource() {
                                                var item = transactionsTable.model.get(styleData.row);
                                                if (item.isInProgress)
                                                    return "qrc:/assets/icon-swap-in-progress.svg";
                                                else if (item.isCompleted)
                                                    return "qrc:/assets/icon-swap-completed.svg";
                                                else if (item.isExpired)
                                                    return "qrc:/assets/icon-failed.svg";
                                                else
                                                    return "qrc:/assets/icon-swap-failed.svg";
                                            }
                                        }
                                        SFLabel {
                                            Layout.alignment: Qt.AlignLeft
                                            Layout.fillWidth: true
                                            font.pixelSize: 14
                                            font.italic: true
                                            wrapMode: Text.WordWrap
                                            text: getStatusText(styleData.value)
                                            verticalAlignment: Text.AlignBottom
                                            color: getTextColor()
                                            function getTextColor () {
                                                var item = transactionsTable.model.get(styleData.row);
                                                if (item.isInProgress || item.isCompleted) {
                                                     return Style.accent_swap;
                                                }
                                                else {
                                                    return Style.content_secondary;
                                                }
                                            }
                                            onTextChanged: {
                                                color = getTextColor();
                                                statusIcon.source = statusIcon.getIconSource();
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        TableViewColumn {
                            id: txSwapActionColumn
                            elideMode: Text.ElideRight
                            width: 40
                            movable: false
                            resizable: false
                            delegate: txActions
                        }

                        function showContextMenu(row) {
                            var data = transactionsTable.model.get(row);
                            txContextMenu.canCopyToken = true;
                            txContextMenu.token = data.token;
                            txContextMenu.cancelEnabled = data.isCancelAvailable;
                            txContextMenu.deleteEnabled = data.isDeleteAvailable;
                            txContextMenu.txID = data.rawTxID;
                            txContextMenu.popup();
                        }

                        Component {
                            id: txActions
                            Item {
                                Item {
                                    width: parent.width
                                    height: transactionsTable.rowHeight
                                    CustomToolButton {
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.right: parent.right
                                        anchors.rightMargin: 12
                                        icon.source: "qrc:/assets/icon-actions.svg"
                                        //% "Actions"
                                        ToolTip.text: qsTrId("general-actions")
                                        onClicked: {
                                            transactionsTable.showContextMenu(styleData.row);
                                        }
                                    }
                                }
                            }
                        }
                    }   // CustomTableView : transactionsTable

                    ContextMenu {
                        id: txContextMenu
                        modal: true
                        dim: false
                        property bool canCopyToken
                        property bool cancelEnabled
                        property bool deleteEnabled
                        property var txID
                        property string token

                        Action {
                            //% "Copy token"
                            text: qsTrId("swap-copy-token")
                            icon.source: "qrc:/assets/icon-copy.svg"
                            enabled: txContextMenu.canCopyToken
                            onTriggered: {
                                BeamGlobals.copyToClipboard(txContextMenu.token);
                            }
                        }

                        Action {
                            //% "Cancel"
                            text: qsTrId("general-cancel")
                            icon.source: "qrc:/assets/icon-cancel.svg"
                            enabled: txContextMenu.cancelEnabled
                            onTriggered: {
                                viewModel.cancelTx(txContextMenu.txID);
                            }
                        }
                        Action {
                            //% "Delete"
                            text: qsTrId("general-delete")
                            icon.source: "qrc:/assets/icon-delete.svg"
                            enabled: txContextMenu.deleteEnabled
                            onTriggered: {
                                //% "The transaction will be deleted. This operation can not be undone"
                                deleteTransactionDialog.text = qsTrId("wallet-txs-delete-message");
                                deleteTransactionDialog.open();
                            }
                        }
                        Connections {
                            target: deleteTransactionDialog
                            onAccepted: {
                                viewModel.deleteTx(txContextMenu.txID);
                            }
                        }
                    }
                
                    ConfirmationDialog {
                        id: deleteTransactionDialog
                        //% "Delete"
                        okButtonText: qsTrId("general-delete")
                    }
                }   // CustomTableView : transactionsTable
            }   // ColumnLayout : transactionsTab
        } // Item : 
    } // Component : offersViewComponent
    
    StackView {
        id: offersStackView

        anchors.fill: parent
        initialItem: offersViewComponent

        pushEnter: Transition {
            enabled: false
        }
        pushExit: Transition {
            enabled: false
        }
        popEnter: Transition {
            enabled: false
        }
        popExit: Transition {
            enabled: false
        }

        onCurrentItemChanged: {
            if (currentItem && currentItem.defaultFocusItem) {
                offersStackView.currentItem.defaultFocusItem.forceActiveFocus();
            }
        }
    }

    function getCoinIcon(coin) {
        switch(coin) {
            case "btc": return "qrc:/assets/icon-btc.svg";
            case "ltc": return "qrc:/assets/icon-ltc.svg";
            case "qtum": return "qrc:/assets/icon-qtum.svg";
            default: return "";
        }
    }

    function getStatusText(value) {
        switch(value) {
            //% "pending"
            case "pending": return qsTrId("wallet-txs-status-pending");
            //% "waiting for sender"
            case "waiting for sender": return qsTrId("wallet-txs-status-waiting-sender");
            //% "waiting for receiver"
            case "waiting for receiver": return qsTrId("wallet-txs-status-waiting-receiver");
            //% "in progress"
            case "receiving": return qsTrId("wallet-txs-status-in-progress");
            //% "in progress"
            case "sending": return qsTrId("wallet-txs-status-in-progress");
            //% "completed"
            case "completed": return qsTrId("wallet-txs-status-completed");
            //% "received"
            case "received": return qsTrId("wallet-txs-status-received");
            //% "sent"
            case "sent": return qsTrId("wallet-txs-status-sent");
            //% "cancelled"
            case "cancelled": return qsTrId("wallet-txs-status-cancelled");
            //% "expired"
            case "expired": return qsTrId("wallet-txs-status-expired");
            //% "failed"
            case "failed": return qsTrId("wallet-txs-status-failed");
            //% "unknown"
            default: return qsTrId("wallet-txs-status-unknown");
        }
    }
}
