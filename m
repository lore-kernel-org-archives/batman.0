Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4F9AE2E6.3090909@inti.gob.ar>
Date: Fri, 27 Apr 2012 15:18:14 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF3@saturn3.aculab.com>	<4F994681.9040300@inti.gob.ar>	<CAJuY50ygkeQgr=CXUpZGJdR8AXQMq3gtEs0WvM5cQeE=ARf3MQ@mail.gmail.com>	<201204262326.06705.lindner_marek@yahoo.de>
	<CAJuY50z3PfkDj0R3VUViZA_RqWk-jfwQSXp4LrgSsaAY+H2_iA@mail.gmail.com>
In-Reply-To: <CAJuY50z3PfkDj0R3VUViZA_RqWk-jfwQSXp4LrgSsaAY+H2_iA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Traffic Control in batman-adv
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,
That's a very good diagram!

Resuming the thread, Sven said that adding a qdisc to wlan0-1 makes no=20
sense. I don't understand completely why, but i guess that once bat0=20
manages wlan0-1, the latter can't work anymore at IP layer, right?

So i've done some tests with bat0. I realized that maybe when i had=20
applied a SFQ qdisc to bat0, the bottleneck was still on wlan0-1, and=20
for that reasons packets were dropped on wlan0-1. Then using a HTB qdisc=20
i limited bat0 rate to a minor value than the wlan0-1 actual output=20
rate, and added some classes inside with SFQ. This way i could see=20
dropped packets at bat0 and SFQ working as expected (and no dropped=20
packets at wlan0-1). However, for this configuration to work, the limit=20
value rate for bat0 has to be smaller than the output rate of wlan0-1,=20
but this value is not fixed in a wireless link. I don't know if it's=20
possible to use another configuration in which it's not necessary to set=20
a fixed limit value to allow bat0 to control the bottleneck.

Regards

Gabriel


El 26/04/2012 01:04 p.m., 3zl Trizonelabs escribi=F3:
> Hi Marek,
> since WBM Athens, where i met you guys,i decided to prepare some stuff
> and organize it on a collaborating site for batman-adv applications
> Everybody is  welcome to join.
> I'll add your email to the Mindmono Mindmap site to get some ideas how
> to organize the site. ( teamlab.com would be nice)
> Have a look at the mindmap
> :http://www.mindomo.com/view.htm?m=3Dbbde50c10b0b4864bde98b83f2a7cf3b
> regards
> 3zl
> Greece/Germany
>
> 2012/4/26 Marek Lindner<lindner_marek@yahoo.de>:
>> On Thursday, April 26, 2012 22:49:24 3zl Trizonelabs wrote:
>>> maybe pic this will help
>>>
>>> http://www.bild.me/bild.php?file=3D9951400Batman-CPE-config.png
>>
>> Hey,
>>
>> that is a very good graphical explanation of the setup! Do you happen to=
 have
>> more of those ? Maybe we should create a page talking about possible net=
work
>> setups and include your stuff there ?
>>
>> Cheers,
>> Marek
