Return-Path: <don@dis.org.nz>
MIME-Version: 1.0
In-Reply-To: <201001042344.02273.lindner_marek@yahoo.de>
References: <201001042344.02273.lindner_marek@yahoo.de>
Date: Tue, 5 Jan 2010 09:23:42 +1300
Message-ID: <591bc9931001041223m13d96837o4d4f95afa08e42e2@mail.gmail.com>
From: Donald Gordon <don@dis.org.nz>
Content-Type: multipart/alternative; boundary=00504502e2d557e9b9047c5c7fdc
Subject: Re: [B.A.T.M.A.N.] batman-adv gateway support
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--00504502e2d557e9b9047c5c7fdc
Content-Type: text/plain; charset=ISO-8859-1

Hi

On Tue, Jan 5, 2010 at 4:44 AM, Marek Lindner <lindner_marek@yahoo.de>wrote:

>
> * The third patch checks whether locally received packets are DHCP queries
> and
> forwards them via uncicast to the best gateway instead of broadcasting
> them.
>
> Would it be possible to decide via a more general mechanism, maybe via a
BPF filter, which packets get sent to the gateway?  For instance, it would
be nice to be able to say that all ARP requests for *.*.*.1 also got sent to
the gateway direct :-)  This would also make adding IPv6 support trivial,
it'd just be another (or a more complex) BPF filter.

donald

--00504502e2d557e9b9047c5c7fdc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br><div class=3D"gmail_quote">On Tue, Jan 5, 2010 at 4:44 AM, Marek =
Lindner <span dir=3D"ltr">&lt;<a href=3D"mailto:lindner_marek@yahoo.de">lin=
dner_marek@yahoo.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
<br>
* The third patch checks whether locally received packets are DHCP queries =
and<br>
forwards them via uncicast to the best gateway instead of broadcasting them=
.<br>
<br></blockquote><div>Would it be possible to decide via a more general mec=
hanism, maybe via
a BPF filter, which packets get sent to the gateway?=A0 For instance, it
would be nice to be able to say that all ARP requests for *.*.*.1 also
got sent to the gateway direct :-)=A0 This would also make adding IPv6 supp=
ort trivial, it&#39;d just be another (or a more complex) BPF filter.<br><b=
r>donald<br></div></div>

--00504502e2d557e9b9047c5c7fdc--
