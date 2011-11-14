Return-Path: <ordex@autistici.org>
Date: Tue, 15 Nov 2011 00:43:13 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111114234312.GA28724@ritirata.org>
References: <mailman.5.1321268402.29081.b.a.t.m.a.n@lists.open-mesh.org>
	<4EC171B2.9070605@inti.gob.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4EC171B2.9070605@inti.gob.ar>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello Gabriel,

On Mon, Nov 14, 2011 at 04:53:22 -0300, gtolon@inti.gob.ar wrote:
> Hi. We are using batman-adv 2011.2.0 with Openwrt Backfire-rc6 on D-Link 
> routers, and we're making some tests with iperf to measure bitrate 
> capabilities between nodes. When we put three nodes aligned we notice 
> that the obtained bitrate between the extreme nodes strongly depends on 
> the batman path between them. To make it clear, we have:
> 
> A ---------- B ---------- C
> 
> With a dinstance of about 20 meters between A and B, and the same 
> distance between B and C. The problem is that sometimes, A and C get 
> connected directly in terms of batman-adv protocol (checked with batctl 
> o), and when that happens, the bitrates are very poor (less than 1Mbps), 
> like if B wasn't there. In fact we disconnected B and obtained very 
> similar results.
> 
> Then we reduced tx power settings on A and C, forcing the B hop between 
> them, and we got much better speeds (~20Mbps). We've read about ELP and 
> think that maybe simple OGM messages are not good to measure link 
> quility between A and C in this example, could that be the problem? In 
> that case is there a way to fix this with actual batman-adv algorithms? 
> Thanks in advance!
> 
> Gabriel
> 

I think other people will give you better answer than this one, but just as
start: OGM are sent in broadcast, which by definition uses a low rate that
implies "better transmission than higher rates".
Therefore a link having an high TQ doesn't necessarily has a good quality at
"high rates" (as you are experiencing).

In my opinion the problem resides in the fact that batman-adv uses broadcast
packets to measure link qualities which leads to the aforementioned problem.

I don't know if ELP would help in this sense because as far as I know it still
uses broadcast packets.

Please guys correct me if I am wrong.


Cheers,



-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
