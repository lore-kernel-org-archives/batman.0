Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1456681096.1958.61.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 28 Feb 2016 18:38:16 +0100
In-Reply-To: <1802876.jh3TWRFVis@sven-edge>
References: <1456616348.1958.16.camel@gmail.com>
 <10118093.UzH4NL7sLW@sven-edge> <1802876.jh3TWRFVis@sven-edge>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batctl: page allocation failure
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

I applied your patch. Besides a compilation warning

/root/git/batman-adv/net/batman-adv/originator.c: In function 'batadv_orig_hardif_seq_print_text':
/root/git/batman-adv/net/batman-adv/originator.c:1364:22: warning: unused variable 'bat_priv' [-Wunused-variable]
  struct batadv_priv *bat_priv;
                      ^

there is no error. 

# batctl -v
batctl 2016.0-4-g7a3d563 [batman-adv: 2016.0-92-gd7c9a9e-dirty]

this is interesting:

batctl o | wc -l
9320

the other nodes tell me 335 or 341 or …

I'm sorry I'm not able to reproduce this issue any more and thank you
for your work for B.A.T.M.A.N. advanced.

best regards,
  Philipp
