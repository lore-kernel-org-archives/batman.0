Return-Path: <dominik@heidler.eu>
References: <1455666670-32409-1-git-send-email-dominik@heidler.eu>
 <11933942.EqGnTx1S2H@bentobox>
From: Dominik Heidler <dominik@heidler.eu>
Message-ID: <56C44D11.3000706@heidler.eu>
Date: Wed, 17 Feb 2016 11:36:01 +0100
MIME-Version: 1.0
In-Reply-To: <11933942.EqGnTx1S2H@bentobox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Allow setting the source mac via
 unix sock
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

Am 17.02.2016 um 09:39 schrieb Sven Eckelmann:
> Your patch also doesn't explain why this feature may be required.

I'm running an alfred master server with this patch, so that I can run a script that will
inject data of legacy clients (that don't have an alfred slave, but need to be crawled).

Regards,
Dominik
