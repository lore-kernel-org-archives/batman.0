Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Neighbor and originator purge timeout
From: oytunyapar@hotmail.com
Date: Wed, 17 Mar 2021 10:39:10 -0000
Message-ID: <20210317103910.1198.71257@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi everybody,

    As I checked from source code, BATADV_PURGE_TIMEOUT value determines:
    1- When a node will be discarded from the neighbor list, if this particular node did not send ELP messages for BATADV_PURGE_TIMEOUT amount of time
    2- When a node will be discarded from the originator list, if this particular node did not send OMG messages for 2 * BATADV_PURGE_TIMEOUT amount of time

    BATADV_PURGE_TIMEOUT is constant, and determined in compile time. It seem, it could not be configured via "batctl" utility.

   Am I correct?


Regards.
Oytun
