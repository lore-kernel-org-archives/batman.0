Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 Nov 2011 09:40:36 +0800
References: <mailman.5.1321268402.29081.b.a.t.m.a.n@lists.open-mesh.org>
	<4EC171B2.9070605@inti.gob.ar>
In-Reply-To: <4EC171B2.9070605@inti.gob.ar>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111150940.36605.lindner_marek@yahoo.de>
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


Hi,

> With a dinstance of about 20 meters between A and B, and the same 
> distance between B and C. The problem is that sometimes, A and C get 
> connected directly in terms of batman-adv protocol (checked with batctl 
> o), and when that happens, the bitrates are very poor (less than 1Mbps), 
> like if B wasn't there. In fact we disconnected B and obtained very 
> similar results.

would you mind sharing the orignator tables of the involved nodes ?


> Then we reduced tx power settings on A and C, forcing the B hop between 
> them, and we got much better speeds (~20Mbps). We've read about ELP and 
> think that maybe simple OGM messages are not good to measure link 
> quility between A and C in this example, could that be the problem? In 
> that case is there a way to fix this with actual batman-adv algorithms? 

You can play with the hop penalty parameter to encourage batman to use fewer 
or more hops (depending on your needs).

Regards,
Marek
