Return-Path: <Kevin.Curtis@farsite.com>
From: Kevin Curtis <Kevin.Curtis@farsite.com>
Date: Thu, 22 Nov 2012 08:12:38 +0000
Message-ID: <E603DC592C92B54A89CEF6B0919A0B1CA7D5A6CC87@SOLO.hq.farsitecommunications.com>
References: <1353499919-28596-1-git-send-email-ordex@autistici.org>
 <1353499919-28596-10-git-send-email-ordex@autistici.org>
 <20121121.125759.322762083309845086.davem@davemloft.net>
 <8108710.8oNxxR0rRd@sven-laptop.home.narfation.org>
In-Reply-To: <8108710.8oNxxR0rRd@sven-laptop.home.narfation.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Use packing of 2 for all
 headers before an ethernet header
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, David Miller <davem@davemloft.net>
Cc: "fubar@us.ibm.com" <fubar@us.ibm.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "rmody@brocade.com" <rmody@brocade.com>, "ron.mercer@qlogic.com" <ron.mercer@qlogic.com>, "linux-driver@qlogic.com" <linux-driver@qlogic.com>, "lindner_marek@yahoo.de" <lindner_marek@yahoo.de>, "jitendra.kalsaria@qlogic.com" <jitendra.kalsaria@qlogic.com>, "andy@greyhouse.net" <andy@greyhouse.net>

>> Agree. But we should get this message also to the other guys

What message would this be?
Are you advocating a different use of #pragma pack()?


Kevin Curtis
Linux Development
FarSite Communications Ltd http://www.farsite.com
Winner of The Queen's Award for Enterprise 2009
tel:=A0 +44 1256 330461
fax:=A0 +44 1256 854931



-----Original Message-----
From: Sven Eckelmann [mailto:sven@narfation.org]=20
Sent: 21 November 2012 18:20
To: David Miller
Cc: ordex@autistici.org; netdev@vger.kernel.org; b.a.t.m.a.n@lists.open-mes=
h.org; lindner_marek@yahoo.de; Kevin Curtis; linux-driver@qlogic.com; ron.m=
ercer@qlogic.com; jitendra.kalsaria@qlogic.com; rmody@brocade.com; andy@gre=
yhouse.net; fubar@us.ibm.com
Subject: Re: Re: [PATCH 9/9] batman-adv: Use packing of 2 for all headers b=
efore an ethernet header

On Wednesday 21 November 2012 12:57:59 David Miller wrote:
> From: Antonio Quartulli <ordex@autistici.org>
> Date: Wed, 21 Nov 2012 13:11:59 +0100
>=20
> > +#pragma pack(2)
>=20
>  ...
>=20
> > -} __packed;
>=20
> The __packed attribute is an abstraction of the actual syntax the=20
> compiler uses, if it is supported at all.
>=20
> Therefore, you can't just unconditionally use the #pragma, and you=20
> would need to use some kind of similar compiler abstraction for it.
>=20
> But to be honest this is really ugly and for very little, if any,=20
> gain.

Agree. But we should get this message also to the other guys

$ git grep pragma -- drivers/net
drivers/net/bonding/bond_3ad.h:#pragma pack(1) drivers/net/bonding/bond_3ad=
.h:#pragma pack() drivers/net/bonding/bond_3ad.h:#pragma pack(8) drivers/ne=
t/bonding/bond_3ad.h:#pragma pack() drivers/net/bonding/bond_alb.c:#pragma =
pack(1) drivers/net/bonding/bond_alb.c:#pragma pack() drivers/net/ethernet/=
brocade/bna/bfa_defs.h:#pragma pack(1) drivers/net/ethernet/brocade/bna/bfa=
_defs.h:#pragma pack() drivers/net/ethernet/brocade/bna/bfa_defs_cna.h:#pra=
gma pack(1) drivers/net/ethernet/brocade/bna/bfa_defs_cna.h:#pragma pack() =
drivers/net/ethernet/brocade/bna/bfa_defs_mfg_comm.h:#pragma pack(1) driver=
s/net/ethernet/brocade/bna/bfa_defs_mfg_comm.h:#pragma pack() drivers/net/e=
thernet/brocade/bna/bfi.h:#pragma pack(1) drivers/net/ethernet/brocade/bna/=
bfi.h:#pragma pack() drivers/net/ethernet/brocade/bna/bfi_cna.h:#pragma pac=
k(1) drivers/net/ethernet/brocade/bna/bfi_cna.h:#pragma pack() drivers/net/=
ethernet/brocade/bna/bfi_enet.h:#pragma pack(1) drivers/net/ethernet/brocad=
e/bna/bfi_enet.h:#pragma pack() drivers/net/ethernet/brocade/bna/cna.h:#pra=
gma pack(1) drivers/net/ethernet/brocade/bna/cna.h:#pragma pack() drivers/n=
et/ethernet/qlogic/qla3xxx.h:#pragma pack(1) drivers/net/ethernet/qlogic/ql=
a3xxx.h:#pragma pack() drivers/net/wan/farsync.c:#pragma pack(1) drivers/ne=
t/wan/farsync.c:#pragma pack()

Kind regards,
	Sven
