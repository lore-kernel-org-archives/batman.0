MIME-Version: 1.0
Date: Wed, 4 Feb 2009 15:03:35 -0300
Message-ID: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
From: Breno Jacinto <breno@freeunix.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Stable adapters for Ad Hoc networks
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

Hello everyone,

  I`m running several experiments involving ad hoc networks. I`ve
selected some well known-to-be-compatible adapters, such as Edimax
(Ralink shipset), Alfa networks (Realtek) and Atheros (madwifi).
Atheros is available only as built-in adapter on the equipement or as
a  PCI board.

  So, I'm experiencing some instability regarding the selection of
the BSSID used by all the nodes. I start the network with a single
node, then another, then another. Now, for a couple of minutes it
works, bu then some nodes start losing sight of each and changing
their BSSIDs to a different value (and they should always use the
same). I'm really running out of
explanations of why this is happening, because these nodes are all
in-range of each other, and should be "pingable" directly. My main
suspect is the driver instability, but then I dont know of any other
better alternatives. I've tested the following USB adapters:

- Edimax EW-7318USg (rt73 drivers)
- Alfa AWUS036H-11g

  And the builtin adapters:

- Atheros chipset AR5007EG


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
