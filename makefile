# Variables set on .env

include .env
export

all:
	make rebuild

rebuild:
	make clean
	make build

clean:
	rm -f fsmanager/* !fsmanager/.gitkeep
	rm -f dapphub/* !dapphub/.gitkeep

build:
	eosiocpp -o fsmanager/fsmanager.wast src/fsmanager.cpp
	eosiocpp -g fsmanager/fsmanager.abi src/fsmanager.cpp
	eosiocpp -o dapphub/dapphub.wast src/dapphub.cpp
	eosiocpp -g dapphub/dapphub.abi src/dapphub.cpp

unlock:
	cleos --wallet-url http://127.0.0.1:6666 --url http://138.197.194.220:8877  wallet unlock --password $(WALLET_PWD)

importKey:
	cleos --wallet-url http://127.0.0.1:6666 --url http://138.197.194.220:8877 wallet import --private-key $(FSMGR_PRIV)

setupacc:
	cleos --wallet-url http://127.0.0.1:6666 --url http://138.197.194.220:8877 system newaccount $(USERAAAAAAAA_ACCOUNT_NAME) $(FSMGR_ACCOUNT_NAME) $(FSMGR_PUB) --stake-net "1 XFS" --stake-cpu "1 XFS" --buy-ram "3 XFS"

buyRam:
	cleos --wallet-url http://127.0.0.1:6666 --url http://138.197.194.220:8877 system buyram $(USERAAAAAAAA_ACCOUNT_NAME) $(FSMGR_ACCOUNT_NAME) "7 XFS"

deploy:
	cleos --wallet-url http://127.0.0.1:6666 --url http://138.197.194.220:8877 set contract $(FSMGR_ACCOUNT_NAME) ~/feesimple_contracts/fsmanager ~/feesimple_contracts/fsmanager/fsmanager.wast ~/feesimple_contracts/fsmanager/fsmanager.abi

pushFakeData:
	cleos --wallet-url http://127.0.0.1:6666 --url http://138.197.194.220:8877 push action $(FSMGR_ACCOUNT_NAME) addproperty '{"author":"$(FSMGR_ACCOUNT_NAME)","name":"Abbey Road Studios","address_1":"3 Abbey Road, St John`s Wood","address_2":"2nd Floor","city":"City of Westminster","region":"London","postal_code":"123456","unit_count":1}' --permission $(FSMGR_ACCOUNT_NAME)
	cleos --wallet-url http://127.0.0.1:6666 --url http://138.197.194.220:8877 push action $(FSMGR_ACCOUNT_NAME) addproperty '{"author":"$(FSMGR_ACCOUNT_NAME)","name":"Lincoln Building","address_1":"Herriman St, 545","address_2":"5th Block","city":"Salt Lake City","region":"Park City","postal_code":"58086","unit_count":7}' --permission $(FSMGR_ACCOUNT_NAME)
