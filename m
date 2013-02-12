Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 12 Feb 2013 13:24:48 +0800
References: <CAPkwMUf0fN-nVMCeMvm=EvrTLzjXK6ajbJsv5-KBZBEQAJUQ-g@mail.gmail.com>
 <CAPkwMUfKFcpt6cQDdJ9OZYQg2vSYWHc3Whdgce_kt2nSk3urpw@mail.gmail.com>
In-Reply-To: <CAPkwMUfKFcpt6cQDdJ9OZYQg2vSYWHc3Whdgce_kt2nSk3urpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201302121324.48418.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Fwd: Beacons colliding with OGMs
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, February 12, 2013 13:00:33 Carlos Rey-Moreno wrote:
> In one of the networks I'm facing from the beginning some problems due
> to collisions, thus reducing the TQ in some links, that I'd like to
> avoid in order to optimize performance. One of the messages that could
> be colliding with the OGMs are the WiFi beacons. I'm a bit confused
> about the beacon transmission. I posted these questions in the
> villagetelco list, but they recommended me to ask them here too. Hope
> you can help me.

Don't know who sent you here but this list does not seem like the right spot 
for your questions. Most of them center around madwifi, ahdemo mode and 
beaconing - none of these are related to batman-adv (unless I misunderstand?).


> - Given the network it is going to be, at least during some months,
> very static (both in mesh nodes and clients) and assuming the beacons
> are coming from the VAP, what values would make sense to use as beacon
> interval and OGM interval, respectively, for avoiding collisions and
> keeping performance?

If you wish to avoid packet collisions in the air I suggest sending less 
packets, hence make the intervals longer. Suggesting exact values is a little 
hard as those always depend on your environment & setup. I'd recommend to 
experiment with these values to find out what works for you.

Cheers,
Marek


