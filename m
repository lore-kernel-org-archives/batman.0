Return-Path: <philipp.psurek@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 13 Jun 2017 12:39:15 +0200
Message-Id: <20170613103916.27299-1-philipp.psurek@gmail.com>
In-Reply-To: <4393196.oYPnlPzS5o@prime>
References: <4393196.oYPnlPzS5o@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: suppress
 implicit-fallthrough compiler
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

Am Dienstag, den 13.06.2017, 10:48 +0200 schrieb Simon Wunderlich:
> Hmm, I don't like this one too much, since it looks cryptic and we
> will have to add up new versions, which I'd like to avoid.
> 
> Did you try to change the wording? I've googled a bit and it seems a
> comment containing the wording "fallthrough" will avoid it. Maybe we should
> just change "fall through" to "fallthrough"?

I also read about the wording but for some reason I do not want to change the
comment; because the many changes I tried were not recognized without a
compiler warning option in conjunction with the complete comment. The now
provided patch is recognized but the comment looks a little bit messed up. It
works if you don't mind the formatting of the code.

Thanks for the opportunity to contribute something to B.A.T.M.A.N.-Advanced.

Best regards,

Philipp

