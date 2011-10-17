Return-Path: <ordex@autistici.org>
Date: Mon, 17 Oct 2011 18:37:55 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111017163754.GA1646@ritirata.org>
References: <4E9C2AA9.4070208@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4E9C2AA9.4070208@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] Unused structs in Catwoman packet buffers
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

Hello Martin,

and thank you for the explanation.

On Mon, Oct 17, 2011 at 03:16:25 +0200, Martin Hundebøll wrote:
> Now here's the question:
> When a list of a certain coding_path becomes empty, should I free the coding_path right away, or should I timestamp it and mark it for removal at a later time. The thing is that I don't know whether a new packet for the same coding_path will arrive in a short moment. If I have just freed the coding_path struct, I would have to spend ressources to initialize it again...
> 
> It is probably a micro-optimiziation and the simplest solution would be to just free it right away, but I would like to have your comments anyways.

In my opinion it would be better to _keep_ the struct even if the corresponding
packet list is empty.

Imagine there are two packet flows going through a relay
node R. If the two coding paths of the two flows have an high coding correlation
at R (coding opportunity?), one of the two packet lists on R will be emptied
several times during the data transmission.

For this reason I think it would be better to wait a fixed time before freeing
such structure. The overhead given by the freeing/reallocating/reinitialising
operation could become not negligible.

I hope that I correctly understood the problem and that my idea was clear :-)

Cheers,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
