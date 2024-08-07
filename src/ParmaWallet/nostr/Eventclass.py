import json, os, hashlib, time
from functions import schnorr_sign
class Event:
    def __init__(self, id=None, pubkey=None, created_at=None, kind=None, tags=None, content=None, sig=None, sec=None, sec_file=None): #note: tags is a mutable object and re-called each time the contructor is used. So, should not directly set it.
        self.pubkey = pubkey #use ""

        if created_at is None:
           self.created_at = int(time.time()) 
        else:
           self.created_at = created_at #number, not string

        self.kind = kind #number, not string
        self.tags = tags or []
        self.content = content #use ""
        self.sig = sig #use ""
       
        self.data = [0,self.pubkey,self.created_at,self.kind,self.tags,self.content] 
        self.json_string = json.dumps(self.data, ensure_ascii=False, separators=(',', ':'))
        self.json_bytes = self.json_string.encode('utf-8')

        if id is None and sec is not None:
            """Will sign"""
            self.id = hashlib.sha256(self.json_bytes).hexdigest() #<32-bytes lowercase hex-encoded sha256 of the serialized event data>, use ""
            self.id_bytes = hashlib.sha256(self.json_bytes).digest()
        elif id is None and sec is None:
            print("No signing") 

        if sec is not None and isinstance(sec, bytes):
            """sign"""
            self.sig = schnorr_sign(msg=self.id_bytes, seckey=sec, aux_rand=os.urandom(32)).hex()
        elif sec is None and id is not None:
            raise KeyError("ID provided, fine, but why provide a private key?")
        elif id is not None: 
            """make final data and leave sig blank"""
            self.data_final= json.dumps({"id": self.id,"pubkey": self.pubkey, "created_at": self.created_at, "kind": self.kind, "tags": self.tags,"content": self.content, "sig": self.sig}, ensure_ascii=False, indent=4)
        elif sig is not None and id is not None:
            """makeing event from presigned data"""
            self.data_final= json.dumps({"id": self.id,"pubkey": self.pubkey, "created_at": self.created_at, "kind": self.kind, "tags": self.tags,"content": self.content, "sig": self.sig}, ensure_ascii=False, indent=4)
            
        """make event, and add signature"""
        self.data_final= json.dumps({"id": self.id,"pubkey": self.pubkey, "created_at": self.created_at, "kind": self.kind, "tags": self.tags,"content": self.content, "sig": self.sig}, ensure_ascii=False, indent=4)
        

    def __repr__(self):
        return f"{self.data_final}"

        #return "{\n" \
        # + "    " + f"\"id\"={self.id},"                 + "\n"  \
        # + "    " + f"\"pubkey\"={self.pubkey},"         + "\n"  \
        # + "    " + f"\"created_at\"={self.created_at}," + "\n"  \
        # + "    " + f"\"kind\"={self.kind},"             + "\n"  \
        # + "    " + f"\"tags\"={self.tags},"             + "\n"  \
        # + "    " + f"\"content\"={self.content},"       + "\n"  \
        # + "    " + f"\"sig\"={self.sig}"                + '\n' + "}"




  