Return-Path: <jay@dslx.net>
From: "Jay Brussels" <jay@dslx.net>
Date: Wed, 12 Nov 2014 07:47:10 -0500
Message-ID: <069201cffe76$c6b720c0$54256240$@dslx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: [B.A.T.M.A.N.] Current OpenWrt build
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@lists.open-mesh.org>

Antonio,

I am planning to start programming Ubiquiti and TP-Link Routers in two =
weeks for a very large BATMAN mesh deployment.

Although many patches I have seen on this list involves multicast =
traffic I have seen some others. =20

Is the current OpenWrt release stable enough for deployment or are there =
some "must have" patches requiring a build from scratch for a successful =
deployment?


Jay Brussels
President
DSL Express
954-757-3254=20
jay@dslx.net





-----Original Message-----
From: B.A.T.M.A.N [mailto:b.a.t.m.a.n-bounces@lists.open-mesh.org] On =
Behalf Of Krishnathiepan Rasanayagam
Sent: Wednesday, November 12, 2014 6:51 AM
To: The list for a Better Approach To Mobile Ad-hoc Networking
Subject: Re: [B.A.T.M.A.N.] Threads in batman-adv

yep. i should have :)
now only freading it out. sorry

thanks alot for replying :)

On Wed, Nov 12, 2014 at 2:47 PM, Antonio Quartulli =
<antonio@meshcoding.com> wrote:
>
>
> On 12/11/14 09:19, Krishnathiepan Rasanayagam wrote:
>> Hi All,
>>
>> Has anyone considered using threads in batman-adv?
>
> did you mean kthread? I don't think this would bring any real benefit.
> You should probably read/understand the rest of the networking stack=20
> in the linux kernel to understand how incoming/outgoing packets are =
handled.
>
>> is is possible to use fork() send.c file?
>
> fork() is a function that is supposed to be used in *userspace* to=20
> create a new *process*.
> This is neither available nor conceptually possible in kernel space.
>
> Maybe you should read a bit more about what you can do and what you=20
> cannot do while developing a kernel module? :)
>
> --
> Antonio Quartulli
>



--
Best regards,
Krishna.

