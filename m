Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 26 Jun 2014 16:40:14 +0200
References: <1403696158-20329-1-git-send-email-sven@narfation.org>
In-Reply-To: <1403696158-20329-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201406261640.14546.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] alfred-gpsd: Calculate size of
	global buffer and not of a single char
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
Cc: Sven Eckelmann <sven@narfation.org>

> The global buffer is 65536 bytes in size and not only 1 byte. This
> statement evaluated to a negative value which was casted to an unsigned
> value (aka... very large value).
> 
> This is a regression was introduced in
> 71dbc00fd879f1e592b07d8397f724fb3f69ac64 ("alfred: Use strncpy instead of
> strcpy for string").

Both patches applied of this series (c67658a, 71b36fa).

Thanks!
    Simon
