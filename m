Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52D66D45.4060301@wirelesspt.net>
Date: Wed, 15 Jan 2014 06:13:09 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net>
In-Reply-To: <52D631FB.9070106@hundeboll.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

inline:

On 01/15/2014 02:00 AM, Martin Hundebøll wrote:
> Hi,
> 
> On 2014-01-14 23:04, cmsv wrote:
>> batman_adv: bat0: The MTU of interface adhoc0 is too small (1528) to
>> handle the transport of batman-adv packets. Packets going over this
>> interface will be fragmented on layer2 which could impact the
>> performance. Setting the MTU to 1546 would solve the problem.
> 
> Did you enable network coding? That would explain the message, as NC
> uses a larger header to make decoding possible at the receiver side.
Yes it is enabled by default as it was with batavd 2013.4.0 with 1528 mtu
> 
> As far as I can tell from a quick look in packet.h, the required MTU
> should be 1532 now. (10 bytes unicast + 8 bytes extra for unicast_4addr
> + 14 ethernet = 32 bytes). Or am I bad at counting bytes?

Regardless of being properly counted or not; dmesg outputs the message
complaining about the need to make mtu 1546.


> // Martin
> 
