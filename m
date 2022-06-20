Return-Path: <cchien@creonexsystems.com>
From: <cchien@creonexsystems.com>
References: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
 <03ca01d86c61$6781b190$368514b0$@creonexsystems.com>
 <049201d88226$14ca9ae0$3e5fd0a0$@creonexsystems.com>
 <3826484.QQW5a1qdB9@ripper>
In-Reply-To: <3826484.QQW5a1qdB9@ripper>
Subject: RE: Question about batman for ARM
Date: Mon, 20 Jun 2022 03:20:19 -0700
Message-ID: <014301d8848f$5874d0b0$095e7210$@creonexsystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Sven Eckelmann' <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

Thank you for the insight.
We definitely do not want to reimplement BATMAN.
Does BATMAN ADV interfaces with the radio via the network driver or does
BATMAN include the network driver?
Can you provide some guidance on where the network driver or interface to
network driver is located within BATMAN?

Regards,
Charles

-----Original Message-----
From: Sven Eckelmann <sven@narfation.org> 
Sent: Friday, June 17, 2022 1:46 AM
To: cchien@creonexsystems.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Question about batman for ARM

On Friday, 17 June 2022 10:41:46 CEST cchien@creonexsystems.com wrote:
[...]
> We would like to use batman with a custom radio and are trying to figure
out what part of the source code we may need to modify to allow batman to
work with a custom radio.
> Custom radio means that the radio is not a commercial radio, such as wi-fi
or Bluetooth.

batman-adv (especially with the B.A.T.M.A.N. IV algo) only requires that the
device itself can transport ethernet frames (with proper unicast and
broadcast behavior). If you need something else then you either need a
virtual interface which does the translation from $whatever to ethernet (and
back) - or you need to reimplement the B.A.T.M.A.N. IV/V algorithms
yourself.

Kind regards,
	Sven

