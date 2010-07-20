Return-Path: <abraham.arce.moreno@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201007202023.17883.lindner_marek@yahoo.de>
References: <1279291156-5297-2-git-send-email-sven.eckelmann@gmx.de>
	<201007201028.12470.sven.eckelmann@gmx.de>
	<20100720.095928.113690788.davem@davemloft.net>
	<201007202023.17883.lindner_marek@yahoo.de>
Date: Tue, 20 Jul 2010 13:41:35 -0500
Message-ID: <AANLkTim4QSjgC2BbrEJEpefQahbkSgaRPPfJ-N0aPL-E@mail.gmail.com>
From: Abraham Arce <abraham.arce.moreno@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: Add batman-adv meshing protocol
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, siwu@hrz.tu-chemnitz.de

Hi,

On Tue, Jul 20, 2010 at 1:23 PM, Marek Lindner <lindner_marek@yahoo.de> wro=
te:
> On Tuesday, July 20, 2010 18:59:28 David Miller wrote:
>> Whoever you leave it to, this needs to be fixed up before this
>> code can be integrated. =A0So if those people are not active or
>> don't have time, you very much should consider the reality that
>> you might have to do these fixups yourself.
>
> No worries - we are quite alive and follow the discussion closely. The ra=
ised
> issues will be addressed pretty soon.
>
> @Sven: I think you do a great job integrating all those patches and trees=
.
> Your helping hand would be really missed. =A0:)

Minor comments...

1. Is it ok to have a README in drivers directory? why not moving it
to Documentation/networking?
2. Compilation error, one extra arguments passed

- stats =3D (struct net_device_stats *)dev_get_stats(skb->dev, &temp);
+ stats =3D (struct net_device_stats *)dev_get_stats(skb->dev, &temp);

  LD      kernel/built-in.o
net/batman-adv/hard-interface.c: In function 'batman_skb_recv':
net/batman-adv/hard-interface.c:482: error: too many arguments to
function 'dev_get_stats'
make[2]: *** [net/batman-adv/hard-interface.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [net/batman-adv] Error 2
make: *** [net] Error 2

Best Regards
Abraham
