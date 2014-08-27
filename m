Return-Path: <ufo@rund.freifunk.net>
Message-ID: <53FDD5D0.4030302@rund.freifunk.net>
Date: Wed, 27 Aug 2014 14:57:52 +0200
From: Ufo <ufo@rund.freifunk.net>
MIME-Version: 1.0
References: <53F59DD3.7060703@aliyun.com> <53F59FA7.2040205@meshcoding.com>
In-Reply-To: <53F59FA7.2040205@meshcoding.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] How to test the non-mesh client roaming feature?
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
To: b.a.t.m.a.n@lists.open-mesh.org

Am 21.08.14 09:28, schrieb Antonio Quartulli:
> Liu,
> 
> On 21/08/14 09:20, liu wrote:
>> Hello, everyone. I want to test the non-mesh client roaming feature.

> this behaviour depends on the client OS (each OS implements a different
> logic), but in general, if all the APs have the same ESSID, the client
> should just switch from one to the other without any user intervention.
> 
> The client should switch when the signal from the new AP gets much
> better than the old one (at least in principle...then each OS may apply
> more robust/smart rules).
> 
> Keep in mind that this has nothing to do with batman-adv but is more
> about the lower layers (wifi stack/driver) and their implementations.
> 

so practically within wifi-field i prefer two ways for testing:

* via wifi-client (Android Smartphone)

The nicest App i found is
https://play.google.com/store/apps/details?id=com.arubanetworks.arubautilities
there you can see the ping to your default gateway and all your APs.
That one you are connected to is marked, the client-switching too..

https://twitter.com/rundfreifunk/status/504611193324326912

* on your mesh-node, best used on your local dhcp-server (openwrt with
batman-adv)

-> cat /tmp/dhcp.leases; arp -a

get the mac-adress or ip-adress of your test-client (the smartphone) and
open two ssh windows:

-> ping <ip-adress>

-> batctl -m bat12 tr <that-adress>

that shows the batman-adv route to your client and all the actually
involved batman-nodes. unfortunatly that traceroute is only to the last
batman-node (that one, your smartphone is connected to) and NOT up to
your client. so maybe that batman-traceroute is working, but the ping
wont. and last but not least, dont get confused with all of these
mac-adresses!

https://twitter.com/rundfreifunk/status/429992988602032129

good luck and greetings
ufo

-- 
---
Freifunk Leipzig http://leipzig.freifunk.net
