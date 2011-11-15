Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4EC2A86F.2000804@inti.gob.ar>
Date: Tue, 15 Nov 2011 14:59:11 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <mailman.3.1321354802.20324.b.a.t.m.a.n@lists.open-mesh.org>
In-Reply-To: <mailman.3.1321354802.20324.b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Problem to find better Route
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

Thank you for your answers. I copy the Originator's tables for the three 
nodes:

A)   (MAC: b2:48:7a:c8:a2:65)

root@OpenWrt:/# batctl o
[B.A.T.M.A.N. adv 2011.2.0, MainIF/MAC: wlan1/b2:48:7a:c8:a2:65 (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
16:d6:4d:3a:3c:3c     0.790s   (213) 16:d6:4d:3a:3c:3c  [     wlan1]: 
16:d6:4d:3a:3d:d8 (193) 16:d6:4d:3a:3c:3c  (213)
16:d6:4d:3a:3d:d8    0.810s   (255) 16:d6:4d:3a:3d:d8 [     wlan1]: 
16:d6:4d:3a:3c:3c  (190) 16:d6:4d:3a:3d:d8 (255)

B)   (MAC: 16:d6:4d:3a:3c:3c)

root@OpenWrt:/# batctl o
[B.A.T.M.A.N. adv 2011.2.0, MainIF/MAC: wlan1/16:d6:4d:3a:3c:3c (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
b2:48:7a:c8:a2:65     0.840s   (235) b2:48:7a:c8:a2:65 [     wlan1]: 
16:d6:4d:3a:3d:d8 (236) b2:48:7a:c8:a2:65 (235)
16:d6:4d:3a:3d:d8    0.640s   (253) 16:d6:4d:3a:3d:d8 [     wlan1]: 
b2:48:7a:c8:a2:65 (205) 16:d6:4d:3a:3d:d8 (253)

C)   (MAC:  16:d6:4d:3a:3d:d8)

root@OpenWrt:/# batctl o
[B.A.T.M.A.N. adv 2011.2.0, MainIF/MAC: wlan1/16:d6:4d:3a:3d:d8 (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
16:d6:4d:3a:3c:3c    0.060s   (208) 16:d6:4d:3a:3c:3c [     wlan1]: 
b2:48:7a:c8:a2:65 (182) 16:d6:4d:3a:3c:3c (208)
b2:48:7a:c8:a2:65    0.090s   (234) b2:48:7a:c8:a2:65 [     wlan1]: 
16:d6:4d:3a:3c:3c (182) b2:48:7a:c8:a2:65 (234)

This is a typical state of the tables. We tryed setting the hop pennalty 
parameter to 1, but the behaviour hasn't changed.

> ------------------------------
>
> Message: 4
> Date: Tue, 15 Nov 2011 00:43:13 +0100
> From: Antonio Quartulli<ordex@autistici.org>
> To: The list for a Better Approach To Mobile Ad-hoc Networking
> 	<b.a.t.m.a.n@lists.open-mesh.org>
> Subject: Re: [B.A.T.M.A.N.] Problem to find better Route
> Message-ID:<20111114234312.GA28724@ritirata.org>
> Content-Type: text/plain; charset=utf-8
>
> Hello Gabriel,
>
> On Mon, Nov 14, 2011 at 04:53:22 -0300,gtolon@inti.gob.ar  wrote:
>> >  Hi. We are using batman-adv 2011.2.0 with Openwrt Backfire-rc6 on D-Link
>> >  routers, and we're making some tests with iperf to measure bitrate
>> >  capabilities between nodes. When we put three nodes aligned we notice
>> >  that the obtained bitrate between the extreme nodes strongly depends on
>> >  the batman path between them. To make it clear, we have:
>> >  
>> >  A ---------- B ---------- C
>> >  
>> >  With a dinstance of about 20 meters between A and B, and the same
>> >  distance between B and C. The problem is that sometimes, A and C get
>> >  connected directly in terms of batman-adv protocol (checked with batctl
>> >  o), and when that happens, the bitrates are very poor (less than 1Mbps),
>> >  like if B wasn't there. In fact we disconnected B and obtained very
>> >  similar results.
>> >  
>> >  Then we reduced tx power settings on A and C, forcing the B hop between
>> >  them, and we got much better speeds (~20Mbps). We've read about ELP and
>> >  think that maybe simple OGM messages are not good to measure link
>> >  quility between A and C in this example, could that be the problem? In
>> >  that case is there a way to fix this with actual batman-adv algorithms?
>> >  Thanks in advance!
>> >  
>> >  Gabriel
>> >  
> I think other people will give you better answer than this one, but just as
> start: OGM are sent in broadcast, which by definition uses a low rate that
> implies "better transmission than higher rates".
> Therefore a link having an high TQ doesn't necessarily has a good quality at
> "high rates" (as you are experiencing).
>
> In my opinion the problem resides in the fact that batman-adv uses broadcast
> packets to measure link qualities which leads to the aforementioned problem.
>
> I don't know if ELP would help in this sense because as far as I know it still
> uses broadcast packets.
>
> Please guys correct me if I am wrong.
>
>
> Cheers,
>
>
>
> -- Antonio Quartulli ..each of us alone is worth nothing.. Ernesto 
> "Che" Guevara ------------------------------ Message: 5 Date: Tue, 15 
> Nov 2011 09:40:36 +0800 From: Marek Lindner <lindner_marek@yahoo.de> 
> To: "The list for a Better Approach To Mobile Ad-hoc Networking" 
> <b.a.t.m.a.n@lists.open-mesh.org> Subject: Re: [B.A.T.M.A.N.] Problem 
> to find better Route Message-ID: 
> <201111150940.36605.lindner_marek@yahoo.de> Content-Type: Text/Plain; 
> charset="iso-8859-1" Hi,
>> >  With a dinstance of about 20 meters between A and B, and the same
>> >  distance between B and C. The problem is that sometimes, A and C get
>> >  connected directly in terms of batman-adv protocol (checked with batctl
>> >  o), and when that happens, the bitrates are very poor (less than 1Mbps),
>> >  like if B wasn't there. In fact we disconnected B and obtained very
>> >  similar results.
> would you mind sharing the orignator tables of the involved nodes ?
>
>
>> >  Then we reduced tx power settings on A and C, forcing the B hop between
>> >  them, and we got much better speeds (~20Mbps). We've read about ELP and
>> >  think that maybe simple OGM messages are not good to measure link
>> >  quility between A and C in this example, could that be the problem? In
>> >  that case is there a way to fix this with actual batman-adv algorithms?
> You can play with the hop penalty parameter to encourage batman to use fewer
> or more hops (depending on your needs).
>
> Regards,
> Marek
>
>
> ------------------------------
