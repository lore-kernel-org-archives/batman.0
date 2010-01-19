Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 19 Jan 2010 20:07:38 +0800
References: <20100118112706.91160@gmx.net>
	<201001182138.32432.lindner_marek@yahoo.de>
	<20100119074334.275290@gmx.net>
In-Reply-To: <20100119074334.275290@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201001192007.38210.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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

On Tuesday 19 January 2010 15:43:34 Juha Yl=F6nen wrote:
> Ah yes, the instructions were actually were in the repository version of
>  the README file, but not in my version of the sources. The sources I have
>  the README is dated 07-11-2009, should I try later version?

Well, the README that is part of the source package matches the sources you=
=20
have. The trunk README might have changed since the last release ...


> The log on the laptop side is pretty sparse:
> [23707.971949] batman-adv: B.A.T.M.A.N. advanced 0.2 (compatibility versi=
on
>  8) loaded [23727.025361] batman-adv: Adding interface: wlan0
> [23727.028964] batman-adv: Interface activated: wlan0
> [23727.028983] batman-adv: Creating new local hna entry: de:ba:6c:f3:8d:53
> [23728.028287] batman-adv: Sending own packet (originator
>  00:22:fa:dc:9a:ce, seqno 1, TQ 255, TTL 50, IDF off) on interface wlan0
>  [00:22:fa:dc:9a:ce] [23729.008099] batman-adv: Sending own packet
>  (originator 00:22:fa:dc:9a:ce, seqno 2, TQ 255, TTL 50, IDF off) on
>  interface wlan0 [00:22:fa:dc:9a:ce] [23729.988106]=20
>
> i.e. no sign of any other packages than own. On the device side the log is
>  in the same format as the one I sent yesterday. I'll try with the latest
>  version from the repository next.

It confirmed what we saw in the other logs: This device (the laptop?) does =
not=20
see the packets from the other side, therefore the protocol correctly assum=
es =20
a dead link. There might be 2 reasons: either the wifi layer does not reall=
y=20
work or batman-adv drops the packets without any further warning.=20
You can try the latest trunk and/or run batctl/wireshark on the laptop to=20
deep-inspect the packets. Feel free to share the logs with us.

Regards,
Marek
