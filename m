Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 7 Apr 2019 13:09:38 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190407110938.GA1471@otheros>
References: <20190111210208.29139-1-linus.luessing@c0d3.blue>
 <3604216.NcQoz811mF@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3604216.NcQoz811mF@rousseau>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Increase purge timeout on
 DAT DHT candidates
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

On Sun, Feb 10, 2019 at 07:59:59PM +0800, Marek Lindner wrote:
> Why not turn last_dht_update into a bool and apply the timeout length based on 
> that bool.

I wasn't sure how to smoothly toggle a DAT entry from local to
global or the other way round without adding locks, several
'if()'s and hackish adjustments of 'last_update'.


Therefore I went for a split the hash table in two in v3: One for
the DAT cache and one for the DAT DHT. Kind of similar to how we
have two tables for the TT for two distinct concepts as well.

While this might need a few more lines of code the result seemed
less complicated and cleaner.

Regards, Linus
