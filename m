Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <4f8bf5df.68c5440a.5c0c.5258@mx.google.com>
References: <Ac0buyfQ0NtM/TK6R9ywgw4De+pmXAAAQxNAAAAS8FA=>
	<4f8bf5df.68c5440a.5c0c.5258@mx.google.com>
Date: Wed, 18 Apr 2012 15:18:54 -0300
Message-ID: <CAHD-aqLiFesS38gLkMbiLtKU30GuamSrSHL5rdaP76zTFLYZrQ@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Problem with multi-radio,
	multi-channel in batman-adv
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

Hi!
I guess you're planning a two.radio mesh to improve troughput.
I recently went trough a similar experience and learnt thanks to this list,
turns out, this might sound counterintuitive at first, but in some
setups, using just 2 channels, spaced further apart, will avoid
interference better than 3 ('almost') overlapping channels.
I.e. Using channel 1 and 11 works better than 1 and 6.

I'm assuming you're not using 5.8g , etc

I suggest you to check a thread on this list last month archives,
'bandwidth degradation on p2p links', there are some interesting
references to read on the subject.

On 4/16/12, puyou.lu <puyou.lu@gmail.com> wrote:
> Hi guys.
> =E3=80=80=E3=80=80I=E2=80=99m trying to make a for nodes WMN using four d=
evices with two wireless
> cards each. I would like to use three different channels to reduce the
> interference, like this:
> =E3=80=80=E3=80=80[Node A]  <- channel 1 ->  [Node B]  <- channel 2 ->  [=
Node C]  <- channel
> 3 ->  [Node D]
> =E3=80=80=E3=80=80First I configure eight wireless cards to the specific =
channel in ad-hoc
> mode using =E2=80=9Ciw dev wlan0 ibss join =E2=80=A6=E2=80=9D.
> =E3=80=80=E3=80=80Then, I think I should add wlan0 and wlan1 to the same =
batman-adv
> interface (that is bat0) in every device. So I need to configure four nod=
es
> with the same commands like:
> =E3=80=80=E3=80=80              echo bat0 > /sys/class/net/wlan0/batman_a=
dv/mesh_iface
> =E3=80=80=E3=80=80              echo bat0 > /sys/class/net/wlan1/batman_a=
dv/mesh_iface
> =E3=80=80=E3=80=80Last configure an IP address to each bat0. (Node A-10.0=
.0.1, Node
> B-10.0.0.2, Node C-10.0.0.3, Node D-10.0.0.4).
> =E3=80=80=E3=80=80But it seem Node A can reach Node B and Node C(using pi=
ng), but can=E2=80=99t for
> Node D.
>
> =E3=80=80=E3=80=80Am I following the right procedure?
> =E3=80=80=E3=80=80Sorry for my poor English. Any help would be appreciate=
d.
>
> Puyou Lu.
>
>
>
