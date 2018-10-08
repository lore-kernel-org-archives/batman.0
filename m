Return-Path: <john@blastwaveinc.com>
References: <babe56e8-b12c-8236-7012-20bb91d400fa@blastwaveinc.com>
 <20181006121445.GA1471@otheros>
From: John Gorkos <john@blastwaveinc.com>
Message-ID: <9849012d-6cee-9877-0dbf-65348cb7c593@blastwaveinc.com>
Date: Mon, 8 Oct 2018 09:43:37 -0700
MIME-Version: 1.0
In-Reply-To: <20181006121445.GA1471@otheros>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. port to ESP32
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

Thank you, Linux and Sven, for your responses.  My comments are in-line.

On 10/6/18 05:14, Linus Lüssing wrote:
> Hi John,
> 
> On Mon, Oct 01, 2018 at 11:01:25AM -0700, John Gorkos wrote:
>> I'm working on a port of the BATMAN-ADV protocol to FreeRTOS,
>> specifically running on the ESP32 from EspressIF.
> 
> Awesome! I've never seen batman-adv running on such a device. And
> it looks like you are already quite close to being the first one
> accomplishing this.
> 
Getting closer.  This weekend, I got the Raspi recognizing the ESP32 as
both an originator and a neigbor:

pi@pi-16:~ $ sudo batctl n
[B.A.T.M.A.N. adv 2017.3, MainIF/MAC: wlan0/b8:27:eb:a0:2a:53
(bat0/ca:bf:41:a6:af:81 BATMAN_IV)]
IF             Neighbor              last-seen
        wlan0	  02:ae:a4:3b:9a:d4    0.150s
pi@pi-16:~ $ sudo batctl o
[B.A.T.M.A.N. adv 2017.3, MainIF/MAC: wlan0/b8:27:eb:a0:2a:53
(bat0/ca:bf:41:a6:af:81 BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
 * 02:ae:a4:3b:9a:d4    0.430s   (255) 02:ae:a4:3b:9a:d4 [     wlan0]


>> [...]
>> Can someone explain to me why this might be occurring, and what I'm
>> missing?  Currently, the code is doing two things:  sending a new OGM
>> with an incrementing sequence number every 1000 ms,
> 
>> and re-broadcasting any received OGMs with a decremented TTL, modified TQ, and DirectLink
>> flag set whenever it receives them (also every 1000 ms or so).
> 
> This sounds wrong. You should not rebroadcast any OGM. You should
> only rebroadcast from the best candidate. I'm wondering whether
> this could cause issues. Or are you testing with a single
> EspressIF and a single Pi only for now?
I must have a misunderstanding of the BATMAN IV OGM mechanism.  My
understanding is that ALL 1-hop (direct) neighbors will rebroadcast the
heard OGM, and beyond that, only best-hop candidates.  Right now, I am
just testing with a single pi and single ESP32, but I have an ample
supply of both.  I figured I'd crawl before I tried to walk.

> 
> If so, then it's probably more likely that just some flags or addresses
> got mixed up. Would it be possible for you to share a tcpdump capture
> from the Pi? You can also check with "batctl log" whether the Pi
> seems to recognize the ESP32 as an originator.
Raspbian comes with debugfs for Batman disabled, so I wound up
recompiling BATMAN for the pi with extra debugging enabled.  It's been
invaluable in tracking down where I'm wrong.
> 
> Also, have you tested with two Pis and no EspressIF? Are Pis
> themselves forming a mesh just fine for you? Just to outrule that
> the issue is on the Pi side.
> 
> Regards, Linus
> 

So, to be clear, I'm working on BATMAN IV and not BATMAN V.  Based on
the open-mesh docs, BATMAN V networks don't rebroadcast OGMs but instead
use the Echo Location Packets.  Am I reading that wrong?  If there's a
compelling reason to move to BATMAN V, I'd be happy to take a look at
it.  We don't anticipate more than 4 hops between links, very low
traffic (ESP32s really don't have the capacity to generate a lot of
traffic quickly) and no more than 20 or so devices in a mesh for starters.

Right now, I'm working on the unicast VLAN TVLV response for the VLAN
TVLV query sent by the Pi when my ESP32 first comes up and begins
announcing.  The Pi is quite insistent that it get an answer... :)

Thank you!
John Gorkos

