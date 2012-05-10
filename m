Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 May 2012 21:12:37 +0800
References: <20120504000852.GA29070@ritirata.org>
In-Reply-To: <20120504000852.GA29070@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205102112.37690.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Improving the roaming procedure: multiple
	roaming within one orig interval
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

> Right now I am working on a concept that would enable such possibility. I
> tried to summarise my ideas on the wiki as well[1] in order to share with
> you the solution I am thinking about.
> 
> The document is still a draft and may not be 100% understandable. If you
> have time and you are curious enough to read the wiki, please drop me your
> feedback, it would really be appreciated :-)

if I understand the document correctly each mesh node a client connects to 
will send a roaming advertisement back to the last known mesh node this client 
was connected to. A few questions come to my mind:

 * Does this already work with the current code ? If not what happens now ?
 * How do all nodes get back in sync ? It sounds to me like for certain while 
a number of nodes claim the same client, right ? Nobody tells the intermediate 
mesh nodes that their client has moved.
 * What if receiving a roaming advertisement triggered an immediate 
(unscheduled) OGM broadcast ? That would potentially speed up the gap and also 
address the "longer path" problem you outlined in the wikipage.

Regards,
Marek
