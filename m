Return-Path: <don@dis.org.nz>
MIME-Version: 1.0
In-Reply-To: <97C5B1C7CD044FEDB67CC3C1E2055BDD@flightrisk>
References: <201009262057.36382.lindner_marek@yahoo.de>
	<1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
	<201009261516.21774.lew.pitcher@digitalfreehold.ca>
	<97C5B1C7CD044FEDB67CC3C1E2055BDD@flightrisk>
Date: Mon, 27 Sep 2010 14:22:52 +1300
Message-ID: <AANLkTimL5Mha3Xr+f9K68aR8u8sS=3HgfG_qSBzmFmyU@mail.gmail.com>
From: Donald Gordon <don@dis.org.nz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv: softif lan loop avoidance
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

On Mon, Sep 27, 2010 at 1:25 PM, DuncanSF
<duncan-tech-openmesh@404.978.org> wrote:
> Doing this defeats part of the purpose of running batman-adv on
> a LAN. =A0Picture the case where nodes have links between each
> other both on their wireless interfaces and through Homeplug
> adapters like the old Netgear XE102 Ethernet-to-Powerline bridge.
>
> Electing a single mesh-to-LAN gateway as proposed will blackhole
> any stations on that LAN unable to reach the elected gateway.
>
> Not everything connected to a LAN port is a standard, reliable
> local area network. =A0*smiles*

Surely in that situation you'd run batman-advanced in a topology where
you only sent batman-encapsulated packets over your unreliable
ethernet (which is unreliable in a similar way to adhoc wifi), and
then either configure up your bat0 interfaces locally on every host or
bridge the bat0 interfaces to nice reliable local ethernet networks.
Then batman would automatically choose the best path over the
available networks to connect your islands of reliability :-)

donald
