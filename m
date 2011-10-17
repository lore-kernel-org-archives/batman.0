Return-Path: <martin@hundeboll.net>
Message-ID: <4E9C2AA9.4070208@hundeboll.net>
Date: Mon, 17 Oct 2011 15:16:25 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Unused structs in Catwoman packet buffers
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

Hi all,

I trying to figure out when to free an unused struct in the catwoman (network coding) packet buffer. Below I will try to describe the principal question, but it all comes down to: Should I use a timeout or just remove it right away.

Heres a short description of the buffering in catwoman:

When a packet arrive at a node and is to be forwarded, catwoman searches a hash-table for packets that can be combined with the just arrived packet. If a match is found, the two packets are combined and transmitted as one; if not, the just arrived packet is added to the buffer, so that the next arriving packet might be combined with it.

To reduce the complexity when searching for packets in the hash table, hash indexes are generated from a key consisting of a mac-source XOR'ed with a mac-destination like this:

   int i;
   uint8_t key[ETH_ALEN];

   for (i = 0; i < ETH_ALEN; i++)
       key[i] = src[i] ^ dst[ETH_ALEN-1-i];

This reduces complexity because catwoman needs only to search a few paths (src-dst-pairs) for possible matching packets. The reverse order of dst makes the key direction-specific.

Each entry in a hash-bin-hlist is denoted a coding_path, which contains the src and dst of the path i question and a reference to list of packets. This list of packets, is where packets are buffered when waiting for a coding opportunity as described above.

Every 10 ms, the hash table is traversed and packets that have been buffered for more than 10 ms are transmitted without being coded. (This gives an avarage buffer time of 15 ms, I know...)

Now here's the question:
When a list of a certain coding_path becomes empty, should I free the coding_path right away, or should I timestamp it and mark it for removal at a later time. The thing is that I don't know whether a new packet for the same coding_path will arrive in a short moment. If I have just freed the coding_path struct, I would have to spend ressources to initialize it again...

It is probably a micro-optimiziation and the simplest solution would be to just free it right away, but I would like to have your comments anyways.

-- 
Kind regards
Martin Hundebøll

+45 61 65 54 61
martin@hundeboll.net

Nordborggade 57, 2. tv
8000 Aarhus C
Denmark
