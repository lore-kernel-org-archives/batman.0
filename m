Return-Path: <martin@hundeboll.net>
Message-ID: <51A450B4.9090901@hundeboll.net>
Date: Tue, 28 May 2013 08:37:40 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1369722202-19422-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1369722202-19422-1-git-send-email-martin@hundeboll.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix possible memleak in
	fragmentation
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
To: b.a.t.m.a.n@lists.open-mesh.org

On 2013-05-28 08:23, Martin Hundebøll wrote:
> Use a variable for return value in batadv_frag_insert_packet() to free
> the allocated struct batadv_frag_list_entry in all cases where it is not
> inserted into a chain.

The possible memleak was introduced by 
9b3eab61754d74a93c9840c296013fe3b4a1b606 ("batman-adv: Receive 
fragmented packets and merge")

// Martin
