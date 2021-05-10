Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
From: asarmanow@gmail.com
Date: Mon, 10 May 2021 07:58:26 -0000
Message-ID: <20210510075826.12523.26721@diktynna.open-mesh.org>
In-Reply-To: <62326514.53yIySlcTU@sven-l14>
References: <62326514.53yIySlcTU@sven-l14>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Sven Eckelmann wrote:

> Why are you only printing selected attributes and not all?
I wanted to reduce the amount to query for the netlink_print_json_entries function. There are only a few of the attributes needed for each of the JSON commands. 

Best regards,
Alex
