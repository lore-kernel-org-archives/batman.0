Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Message-ID: <852bdcd2-f7e5-531e-8602-28f966df558a@web.de>
Date: Tue, 1 Nov 2022 20:31:31 +0100
MIME-Version: 1.0
Subject: Re: Question about batman for ARM
References: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
 <3826484.QQW5a1qdB9@ripper>
 <014301d8848f$5874d0b0$095e7210$@creonexsystems.com>
 <20961862.b4RiU9qLUR@ripper>
 <01ba01d8ee22$bc00d6e0$340284a0$@creonexsystems.com>
Content-Language: en-US
From: Moritz Warning <moritzwarning@web.de>
In-Reply-To: <01ba01d8ee22$bc00d6e0$340284a0$@creonexsystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Charles,

batman-adv is part of the Linux kernel. So it might very well be present o=
n your system already.
But you might need to install batctl package to enable and configure it.

On 11/1/22 19:49, cchien@creonexsystems.com wrote:
> Hi Sven,
>
> Thank you for your past suggestions.
> We are now looking into getting BATMAN working on a Zynq-7000 Xilinx FPG=
A.
> This FPGA hosts dual-arm A9 cores. We have successfully loaded up Ubuntu=
 on
> this platform and it is running
> Linux version 4.19.0-xilinx-v2019.2 (oe-user@oe-host) (gcc version 8.2.0
> (GCC))
>
> The above line is from cat /proc/version.
>
> Can you point me to a BATMAN installation for this OS and platform? I co=
uld
> not find any resources online for this.
> The way suggested by BATMAN home page does not work for some reason.
>
> Thank you for your help.
>
> Regards,
> Charles
> _____________
> CreoNex Systems
> 2625 Townsgate Road, Suite 330
> Westlake Village, CA 91320
> www.creonexsystems.com
> (805) 558-9687
> This message (including any attachments) is for the named addressee(s)'s=
 use
> only. It may contain sensitive, confidential, private proprietary or leg=
ally
> privileged information intended for a specific individual and purpose, a=
nd
> is protected by law. If you are not the intended recipient, please
> immediately delete it and all copies of it from your system, destroy any
> hard copies of it and notify the sender. Any use, disclosure, copying, o=
r
> distribution of this message and/or any attachments is strictly prohibit=
ed.
>
>
> -----Original Message-----
> From: Sven Eckelmann <sven@narfation.org>
> Sent: Monday, June 20, 2022 5:51 AM
> To: cchien@creonexsystems.com
> Cc: b.a.t.m.a.n@lists.open-mesh.org
> Subject: Re: Question about batman for ARM
>
> On Monday, 20 June 2022 12:20:19 CEST cchien@creonexsystems.com wrote:
>> Does BATMAN ADV interfaces with the radio via the network driver or
>> does BATMAN include the network driver?
>
> As said before, it is interfacing with the generic ethernet netdev layer=
 of
> the kernel. For example in:
>
> *
> https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b8=
9025
> 2a865efa91:/net/batman-adv/hard-interface.c#l727
> *
> https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b8=
9025
> 2a865efa91:/net/batman-adv/send.c#l108
> *
> https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b8=
9025
> 2a865efa91:/net/batman-adv/hard-interface.c#l185
>
> There are a lot of other places when it uses the abstraction interfaces =
of
> the kernels for ethernet related communication.
>
> For B.A.T.M.A.N. V, it is also trying to get throughput information via
> various generic kernel functionality:
>
> *
> https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b8=
9025
> 2a865efa91:/net/batman-adv/bat_v_elp.c#l67
>
> There is also one detection for wifi interfaces to decide whether broadc=
ast
> messages should be repeated or not:
>
> *
> https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b8=
9025
> 2a865efa91:/net/batman-adv/hard-interface.c#l877
>
>
>> Can you provide some guidance on where the network driver or interface
>> to network driver is located within BATMAN?
>
> It is not talking directly to the driver. It is always using abstraction
> layers. Either the normal network core, ethernet or cfg80211 abstraction
> interfaces. But these don't abstract the requirement for ethernet
> compatibility away - the underlying device must provide this either dire=
ctly
> or via a wrapper. Just perform a `git grep -e ETH_ -e eth_ -e ethhdr` to=
 see
> that it is build around the concept of ethernet packets.
>
> Also things like originators and the complete translation table only wor=
ks
> with ethernet addresses.
>
> Kind regards,
> 	Sven
