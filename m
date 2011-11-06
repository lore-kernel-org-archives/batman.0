Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKeC-QEJAJVk1=bdB0R6iqu_Q5NBdcgL3=qU9-KLg8k7zbCKMQ@mail.gmail.com>
References: <CAKeC-QFhm8CgyT8HwGqPwtS=E2g_2Haq3bUK2p+GZnppnwUBgQ@mail.gmail.com>
	<201111062157.15824.lindner_marek@yahoo.de>
	<CAKeC-QEJAJVk1=bdB0R6iqu_Q5NBdcgL3=qU9-KLg8k7zbCKMQ@mail.gmail.com>
Date: Sun, 6 Nov 2011 18:27:46 +0200
Message-ID: <CAKeC-QGBb3n-_x0rpvp-BFy4NuHdsh_hOPUwh4wRHvH3xkuT8Q@mail.gmail.com>
From: Wayne Abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Fwd:  MTU issue
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

---------- Forwarded message ----------
From: Wayne Abroue <plettpc@gmail.com>
Date: Sun, Nov 6, 2011 at 5:46 PM
Subject: Re: [B.A.T.M.A.N.] MTU issue
To: Marek Lindner <lindner_marek@yahoo.de>


Hi Marek

Thank you for answering, I am sorry I did not supply more info as I
had already moved to a older release and everything just worked.
I have 35 units all running on my mesh with bat-adv and all are
working quite fine.

However using the latest trunk Openwrt, batman-adv it simply does not
communicate via the bat0 interface.

bat0 is up, batctl confirms correct interface, MTU set at 1527 or 1528
or even a touch higher still does not produce batctl pings or
originator lists.

Thus I was wondering if anybody has had the same problem, to assist me
compiling WRT trunk with a older version, I tried the Wiki procedure
for older version editing makefile to 2010.2.0 which produced a error
, " can;t remove /usr/sbin/batcl ;permissions at the build stage.

Any help would be appreciated,

Wayne

On Sun, Nov 6, 2011 at 3:57 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
>
> Hi,
>
>> I had the same issue previously, but 1528 did not do it.
>> I have since changed build on that unit and can't remember the actual
>> value I used, But it was larger.
>>
>> All I did was increase the value until the warning disappeared, and
>> everything started working as advertised.
>
> what do you mean with "working as advertised" ? It should work even if you get
> this warning. All it does is fragmenting your traffic.
>
> Setting the MTU to 1528 works for me. Without providing more information about
> your setup and giving us the number which seemingly "fixed" it for you nobody
> can help you.
>
> Regards,
> Marek
>
