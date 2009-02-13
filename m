MIME-Version: 1.0
Date: Thu, 12 Feb 2009 23:42:44 -0300
Message-ID: <2ced936d0902121842k7ff76dc8o7c7d303a685a78bd@mail.gmail.com>
From: Breno Jacinto <breno@freeunix.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N L2 over a Bluetooth PAN
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello,

    I'm experimenting on heterogeneous ad hoc networks, which today
are still very restricted in terms of hardware availability for
off-the-shelf devices. Actually, the two most common technologies
available today are 802.11 and Bluetooth, being this last one able to
form simple personal area networks in the form of piconets.

     In practical terms, the BlueZ stack of the Linux allows the
formation of Bluetooth PANs consisting of up to 8 nodes, but it's an
incredibly difficult process - actually, the piconet master needs to
bridge connections so that all other devices in the network, which
depend on this master, are able to reach it other directly - or at
least feel like they are doing that. In fact, everything is just an
emulation, since Bluetooth is a connection-oriented technology.

     BNEP (Bluetooth Network Encapsulation Protocol) is the piece
responsible for emulating an Ethernet network over Bluetooth, and
theoretically any IP and above protocols can be used. Trying with
simple IP broadcasts over a Bluetooth network shows that it works, but
the problem comes when I try to do "straight" layer 2 broadcasts (not
coming from the IP layer), such as the ones that BATMAN L2 does.

    I tried to run BATMAN and add the interfaces used on each device -
pan0 for the master, which is a bridge device, and bnep0 for the
slave, but the frame dont seem to reach any destination on the
network. The originators table remains empty on both sides of the
connection. Running Wireshark shows the frame being generated, but
never reaching anyone.

    So, I still cannot figure out why this is happening. I'd like to
know if anyone has adventured in doing something similar and
succeeded.


best regards,

--=20
--=20
:: Breno Jacinto ::
:: breno - at - gprt.ufpe.br ::
:: FingerPrint ::
   2F15 8A61 F566 E442 8581
   E3C0 EFF4 E202 74B7 7484
:: Persistir no dif=EDcil =E9 a =FAnica maneira de torn=E1-lo f=E1cil algum=
 dia.  ::
