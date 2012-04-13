Return-Path: <christian@solvare.se>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1257)
From: Christian Huldt <christian@solvare.se>
In-Reply-To: <CAKLmikN=yGHL8QZomD=GsaKYcZchd=r7kvsjsyxMCx2CYNjbzw@mail.gmail.com>
Date: Fri, 13 Apr 2012 10:52:07 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <86BF280A-4090-4396-A4B2-94E69FC79F60@solvare.se>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com>
	<CAKLmikNuMEiG2SN+H8bJkwRXszMayPpn_qDcf1faCjhrow6NdQ@mail.gmail.com>
	<201204130017.31711.lindner_marek@yahoo.de>
	<20120413062241.GA14395@ritirata.org>
	<CAKLmikN=yGHL8QZomD=GsaKYcZchd=r7kvsjsyxMCx2CYNjbzw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

13 apr 2012 kl. 09:29 Mitar wrote:
> On Fri, Apr 13, 2012 at 8:22 AM, Antonio Quartulli =
<ordex@autistici.org> wrote:
>> A little remark here. You MUST use interfaces that support ethernet =
frames
>> transmission. Therefore (IIRC) you can use tap interfaces but not tun =
ones.
>=20
> L2TP tunnel is creates a L2 tun interface, no?


Just asking to educate myself.

Why would you use L2TP rather than just IPsec?
With KLIPS you would get a ethernet style device ipsec0, that should =
work fine with batman, no?=
