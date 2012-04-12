Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 13 Apr 2012 00:13:48 +0200
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<20120412120002.GE8528@ritirata.org>
	<CAKLmikOf_M5Btn3rmWLHQbnq+wiFooZDuJrcDJDLTUs6CjB+jw@mail.gmail.com>
In-Reply-To: <CAKLmikOf_M5Btn3rmWLHQbnq+wiFooZDuJrcDJDLTUs6CjB+jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201204130013.49047.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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
Cc: Jernej Kos <kostko@unimatrix-one.org>

On Thursday, April 12, 2012 19:10:42 Mitar wrote:
> On Thu, Apr 12, 2012 at 2:00 PM, Antonio Quartulli <ordex@autistici.org> 
wrote:
> > but only when the packet format (or something really
> > crucial) is touched.
> 
> But couldn't the packet format be made so that unknown values in there
> are simply ignored? And also ignore unknown packet types? So that at
> least connectivity is possible, but not as good as it could be? For
> example, if we have some node which reconnects after a month, it would
> be great that it still is able to connect, so that we can at least
> upgrade it.

Yes, exactly that is on the feature todo list (and more) to ensure better 
backward compatibility in the future.


> > exactly. You can add/remove interfaces at run-time. Creating a bridge
> > with all the tunnels would not be good because it would not make
> > batman-adv exploit the interface diversity.
> 
> And it would also see all nodes as directly connected together? So:
> 
> [nodeA] --- [tunA on server, tunB on server] --- [nodeB]
> 
> If I bridge tunA and tunB together, nodeA will think that there is
> only one hop to nodeB, no?

Correct.

Regards,
Marek
