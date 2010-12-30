Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Dec 2010 17:47:34 +0100
References: <20101216001530.GD2104@ritirata.org>
In-Reply-To: <20101216001530.GD2104@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201012301747.35093.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] HNAs Announcements and Roaming management v2]
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

> A lot of things have changed since the previous version of this paper.
> 
> As usual, feel free to comment it. I'll wait for your feedback :)

we are sitting here together with your paper in one hand and warm apfelstrudel 
in the other. After some discussion we came up with a list of questions / 
ideas that should we discuss further:

* Is HNA_VERSION_NUM increased with every translation table change (client 
joins/disconnects) or does a HNA version may span multiple joins/disconnects ?

* In case of a HNA diff sent via TT_QUERY_RESPONSE you suggest using the 
multicast bit to distinguish joins from disconnects which breaks the upcoming 
multicast optimization as it uses HNA to announce multicast group membership. 
Using an extra flag seems to be the better solution.

* Forwarding a packet (roaming advanced) needs to be defined in more detail to 
make sure that we don't introduce traffic loops. For example, what happens if 
one node on the path already received the delete update but not the add update 
or if some nodes received the add update and others not, etc.

* Linus suggested to add a flag for the "roaming delete" event which says 
"don't delete me if I am the only route" to avoid that the source has no route 
until it received the "add" event from the new orig node.

* How to handle mac address conflicts ?

* The OGM packet format with the appended HNA diffs is missing ? Don't forget 
to add a HNA diff length field otherwise the OGM aggregation won't work.

* The current HNA fragmenation proposal sounds rather fragile and susceptible 
to race conditions. If the a HNA fragment gets lost and the receiving node 
requests it to be resent before or after a new HNA event took place, etc
Therefore we'd like to suggest a simplification by always sending the whole 
translation table instead of specific fragments. It does not seem to be a big 
problem as direct neighbors also can answer with the full table.

* If neighbors can answer with the whole table then we might be able to avoid 
the diff history on each and every node. A TT_QUERY_REQUEST could always 
requests the full table instead of the diffs.

Hope you find this input useful - happy new year !

Regards,
Marek

